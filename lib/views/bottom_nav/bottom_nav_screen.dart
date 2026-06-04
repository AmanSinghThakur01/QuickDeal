import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickdeal/core/constants/app_colors.dart';

import 'package:quickdeal/views/auth/chat/chat_screen.dart';
import 'package:quickdeal/views/auth/product/sell_product_screen.dart';
import 'package:quickdeal/views/favorite/favorite_screen.dart';

import '../../viewmodels/bottom_nav/bottom_nav_viewmodel.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';

class BottomNavScreen extends StatelessWidget {
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavViewModel>(
      builder: (context, vm, child) {
        return Scaffold(
          body: IndexedStack(
            index: vm.currentIndex,
            children: const [
              HomeScreen(),
              FavoriteScreen(),
              SellProductScreen(),
              ChatScreen(),
              ProfileScreen(),
            ],
          ),

          floatingActionButton: _AnimatedFAB(
            onPressed: () => vm.changeIndex(2),
            isActive: vm.currentIndex == 2,
          ),

          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,

          bottomNavigationBar: _BottomBar(vm: vm),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
// Animated FAB
// ─────────────────────────────────────────────
class _AnimatedFAB extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isActive;

  const _AnimatedFAB({required this.onPressed, required this.isActive});

  @override
  State<_AnimatedFAB> createState() => _AnimatedFABState();
}

class _AnimatedFABState extends State<_AnimatedFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _rotateAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.88).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _rotateAnim = Tween<double>(begin: 0.0, end: 0.125).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void didUpdateWidget(_AnimatedFAB oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnim.value,
          child: Transform.rotate(
            angle: _rotateAnim.value * 3.14159,
            child: child,
          ),
        );
      },
      child: FloatingActionButton(
        elevation: 6,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        onPressed: widget.onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (child, anim) =>
              ScaleTransition(scale: anim, child: child),
          child: Icon(
            widget.isActive ? Icons.close_rounded : Icons.add_rounded,
            key: ValueKey(widget.isActive),
            size: 28,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Bottom Bar
// ─────────────────────────────────────────────
class _BottomBar extends StatelessWidget {
  final BottomNavViewModel vm;

  const _BottomBar({required this.vm});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      elevation: 12,
      shadowColor: Colors.black26,
      child: SizedBox(
        height: 65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              index: 0,
              currentIndex: vm.currentIndex,
              activeIcon: Icons.home_rounded,
              inactiveIcon: Icons.home_outlined,
              label: 'Home',
              onTap: () => vm.changeIndex(0),
            ),
            _NavItem(
              index: 1,
              currentIndex: vm.currentIndex,
              activeIcon: Icons.favorite_rounded,
              inactiveIcon: Icons.favorite_border_rounded,
              label: 'Saved',
              onTap: () => vm.changeIndex(1),
            ),

            // Notch spacer
            const SizedBox(width: 48),

            _NavItem(
              index: 3,
              currentIndex: vm.currentIndex,
              activeIcon: Icons.chat_rounded,
              inactiveIcon: Icons.chat_bubble_outline_rounded,
              label: 'Chat',
              onTap: () => vm.changeIndex(3),
            ),
            _NavItem(
              index: 4,
              currentIndex: vm.currentIndex,
              activeIcon: Icons.person_rounded,
              inactiveIcon: Icons.person_outline_rounded,
              label: 'Profile',
              onTap: () => vm.changeIndex(4),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Individual Nav Item
// ─────────────────────────────────────────────
class _NavItem extends StatefulWidget {
  final int index;
  final int currentIndex;
  final IconData activeIcon;
  final IconData inactiveIcon;
  final String label;
  final VoidCallback onTap;

  const _NavItem({
    required this.index,
    required this.currentIndex,
    required this.activeIcon,
    required this.inactiveIcon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: widget.index == widget.currentIndex ? 1.0 : 0.0,
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 1.18).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void didUpdateWidget(_NavItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.index == widget.currentIndex) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isActive = widget.index == widget.currentIndex;

    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 56,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _scaleAnim,
              builder: (context, child) => Transform.scale(
                scale: _scaleAnim.value,
                child: child,
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.primary.withOpacity(0.12)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, anim) =>
                      ScaleTransition(scale: anim, child: child),
                  child: Icon(
                    isActive ? widget.activeIcon : widget.inactiveIcon,
                    key: ValueKey(isActive),
                    size: 24,
                    color: isActive
                        ? AppColors.primary
                        : Colors.grey.shade500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 2),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 10,
                fontWeight:
                isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive
                    ? AppColors.primary
                    : Colors.grey.shade500,
              ),
              child: Text(widget.label),
            ),
          ],
        ),
      ),
    );
  }
}