import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,

      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF8FAFC), Color(0xFFE2E8F0)],

          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),

      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                // WIFI ICON CONTAINER
                Container(
                  width: 130,
                  height: 130,

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(35),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),

                        blurRadius: 25,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),

                  child: const Icon(
                    Icons.wifi_off_rounded,

                    size: 70,

                    color: Color(0xFF2563EB),
                  ),
                ),

                const SizedBox(height: 40),

                // TITLE
                const Text(
                  "No Internet Connection",

                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 28,

                    fontWeight: FontWeight.bold,

                    color: Color(0xFF0F172A),

                    letterSpacing: 0.3,
                  ),
                ),

                const SizedBox(height: 14),

                // SUBTITLE
                const Text(
                  "Please check your internet connection and try again.",

                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 16,

                    height: 1.5,

                    color: Color(0xFF64748B),
                  ),
                ),

                const SizedBox(height: 35),

                // LOADING CARD
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(18),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),

                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),

                  child: const Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,

                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,

                          color: Color(0xFF2563EB),
                        ),
                      ),

                      SizedBox(width: 14),

                      Text(
                        "Waiting for connection...",

                        style: TextStyle(
                          fontSize: 15,

                          fontWeight: FontWeight.w500,

                          color: Color(0xFF334155),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
