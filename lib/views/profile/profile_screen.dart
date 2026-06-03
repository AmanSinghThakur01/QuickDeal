import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../viewmodels/auth/auth_viewmodel.dart';
import '../../viewmodels/profile/profile_viewmodel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  bool _loaded = false;
  bool _fieldsFilled = false;

  @override
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_loaded) {
      final auth = context.read<AuthViewModel>();
      final profile = context.read<ProfileViewModel>();
      final uid = auth.currentUser?.uid;

      if (uid != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          profile.loadUser(uid);
        });
      }

      _loaded = true;
    }
  }

  // Fill controllers only once after user data loads — avoids cursor-jump bug
  void _fillFieldsIfNeeded(dynamic user) {
    if (!_fieldsFilled && user != null) {
      phoneController.text = user.phone;
      addressController.text = user.address;
      _fieldsFilled = true;
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthViewModel>();
    final profile = context.watch<ProfileViewModel>();
    final user = profile.user ?? auth.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("User not found")),
      );
    }

    _fillFieldsIfNeeded(user);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: profile.isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeader(user, profile, context)),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildSectionLabel("Contact Info"),
                const SizedBox(height: 10),
                _buildCard(
                  child: Column(
                    children: [
                      _field(
                        icon: Icons.phone_outlined,
                        label: "Phone Number",
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 14),
                      _field(
                        icon: Icons.location_on_outlined,
                        label: "Address",
                        controller: addressController,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildSectionLabel("Account Info"),
                const SizedBox(height: 10),
                _buildCard(
                  child: _infoRow(
                    icon: Icons.calendar_today_outlined,
                    title: "Joining Date",
                    value: user.createdAt.isEmpty
                        ? "Not Available"
                        : user.createdAt.split(" ").first,
                  ),
                ),
                const SizedBox(height: 28),
                _saveButton(user, profile, context),
                const SizedBox(height: 12),
                _logoutButton(context, auth),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(dynamic user, ProfileViewModel profile, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 64, bottom: 36),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primary.withOpacity(0.75),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(36)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (user.photoUrl.isEmpty) return;
              showDialog(
                context: context,
                builder: (_) => Dialog(
                  backgroundColor: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: InteractiveViewer(
                      child: Image.network(user.photoUrl),
                    ),
                  ),
                ),
              );
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 58,
                    backgroundColor: Colors.white24,
                    backgroundImage: user.photoUrl.isNotEmpty
                        ? NetworkImage(user.photoUrl)
                        : null,
                    child: user.photoUrl.isEmpty
                        ? const Icon(Icons.person, size: 62, color: Colors.white)
                        : null,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () async {
                      final picker = ImagePicker();

                      final pickedFile = await picker.pickImage(
                        source: ImageSource.gallery,
                        imageQuality: 80,
                      );

                      if (pickedFile == null) return;

                      final auth = context.read<AuthViewModel>();

                      final uid = auth.currentUser?.uid;

                      if (uid == null) return;

                      await profile.updatePhoto(
                        uid: uid,
                        image: File(pickedFile.path),
                      );

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Profile photo updated successfully"),
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        size: 18,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            user.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.email_outlined, size: 14, color: Colors.white70),
              const SizedBox(width: 5),
              Text(
                user.email,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          color: Colors.grey.shade500,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _field({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, size: 20),
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
        filled: true,
        fillColor: const Color(0xFFF8F9FC),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 20, color: AppColors.primary),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _saveButton(dynamic user, ProfileViewModel profile, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        icon: const Icon(Icons.check_rounded, size: 20),
        label: const Text(
          "Save Changes",
          style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w600),
        ),
        onPressed: () async {
          await profile.updateProfile(
            uid: user.uid,
            phone: phoneController.text,
            address: addressController.text,
          );
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text("Profile updated successfully"),
                  ],
                ),
                backgroundColor: Colors.green.shade600,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _logoutButton(BuildContext context, AuthViewModel auth) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.red.shade600,
          side: BorderSide(color: Colors.red.shade200),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        icon: Icon(Icons.logout_rounded, size: 20, color: Colors.red.shade600),
        label: Text(
          "Logout",
          style: TextStyle(
            fontSize: 15.5,
            fontWeight: FontWeight.w600,
            color: Colors.red.shade600,
          ),
        ),
        onPressed: () => _logout(context, auth),
      ),
    );
  }

  Future<void> _logout(BuildContext context, AuthViewModel auth) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Logout", style: TextStyle(fontWeight: FontWeight.w700)),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Logout"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await auth.logout();
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.login,
              (_) => false,
        );
      }
    }
  }
}