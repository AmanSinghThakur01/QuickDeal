import 'package:flutter/material.dart';
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

  bool loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!loaded) {
      final auth = context.read<AuthViewModel>();

      final profile = context.read<ProfileViewModel>();

      final uid = auth.currentUser?.uid;

      if (uid != null) {
        profile.loadUser(uid);
      }

      loaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthViewModel>();

    final profile = context.watch<ProfileViewModel>();

    final user = profile.user ?? auth.currentUser;

    if (user == null) {
      return const Scaffold(body: Center(child: Text("User not found")));
    }

    phoneController.text = user.phone;

    addressController.text = user.address;

    return Scaffold(
      backgroundColor: AppColors.background,

      body: profile.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,

                    padding: const EdgeInsets.only(top: 70, bottom: 30),

                    decoration: const BoxDecoration(
                      color: AppColors.primary,

                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(40),
                      ),
                    ),

                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (user.photoUrl.isEmpty) {
                              return;
                            }

                            showDialog(
                              context: context,

                              builder: (_) {
                                return Dialog(
                                  child: InteractiveViewer(
                                    child: Image.network(user.photoUrl),
                                  ),
                                );
                              },
                            );
                          },

                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 60,

                                backgroundColor: Colors.white,

                                backgroundImage: user.photoUrl.isNotEmpty
                                    ? NetworkImage(user.photoUrl)
                                    : null,

                                child: user.photoUrl.isEmpty
                                    ? const Icon(Icons.person, size: 70)
                                    : null,
                              ),

                              Positioned(
                                bottom: 0,

                                right: 0,

                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,

                                    shape: BoxShape.circle,
                                  ),

                                  child: IconButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Photo update next step",
                                          ),
                                        ),
                                      );
                                    },

                                    icon: const Icon(Icons.camera_alt),
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

                            fontSize: 24,

                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          user.email,

                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20),

                    child: Column(
                      children: [
                        _field(
                          icon: Icons.phone,

                          label: "Phone",

                          controller: phoneController,
                        ),

                        const SizedBox(height: 18),

                        _field(
                          icon: Icons.location_on,

                          label: "Address",

                          controller: addressController,

                          maxLines: 3,
                        ),

                        const SizedBox(height: 18),

                        _tile(
                          icon: Icons.calendar_today,

                          title: "Joining Date",

                          value:
                          user.createdAt.isEmpty

                              ? "Not Available"

                              : user.createdAt
                              .split(" ")
                              .first,
                        ),

                        const SizedBox(height: 30),

                        SizedBox(
                          width: double.infinity,

                          height: 56,

                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                            ),

                            onPressed: () async {
                              await profile.updateProfile(
                                uid: user.uid,

                                phone: phoneController.text,

                                address: addressController.text,
                              );

                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Profile Updated"),
                                  ),
                                );
                              }
                            },

                            child: const Text("Save Changes"),
                          ),
                        ),

                        const SizedBox(height: 18),

                        SizedBox(
                          width: double.infinity,

                          height: 56,

                          child: OutlinedButton(
                            onPressed: () {
                              _logout(context, auth);
                            },

                            child: const Text("Logout"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _field({
    required IconData icon,

    required String label,

    required TextEditingController controller,

    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,

      maxLines: maxLines,

      decoration: InputDecoration(
        prefixIcon: Icon(icon),

        labelText: label,

        filled: true,

        fillColor: Colors.white,

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
      ),
    );
  }

  Widget _tile({
    required IconData icon,

    required String title,

    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(18),
      ),

      child: Row(
        children: [
          Icon(icon),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(title),

                const SizedBox(height: 4),

                Text(
                  value,

                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _logout(BuildContext context, AuthViewModel auth) async {
    final confirm = await showDialog(
      context: context,

      builder: (_) => AlertDialog(
        title: const Text("Logout"),

        content: const Text("Are you sure?"),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },

            child: const Text("Cancel"),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, true);
            },

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
