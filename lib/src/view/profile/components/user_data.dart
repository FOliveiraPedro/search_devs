import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserData extends StatelessWidget {
  final String data;
  final IconData icon;
  const UserData({required this.data, required this.icon,super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(
            0xFF4A5568,
          ),
          size: 24,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          data,
          style: GoogleFonts.inter(
              color: const Color(
                0xFF4A5568,
              ),
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
