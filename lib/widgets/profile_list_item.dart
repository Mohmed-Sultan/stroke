import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/constants/app_colors.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final Color? iconColor; // Optional: for specific icon colors like logout

  const ProfileListItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
        child: Row(
          children: [
            Icon(icon, color: iconColor ?? AppColors.textColor.withOpacity(0.7), size: 24),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 16, color: AppColors.textColor),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }
}