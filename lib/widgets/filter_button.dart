import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/constants/app_colors.dart';

class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  const FilterButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // تقليل الـ padding قليلاً
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.grey[400]!,
            width: 1.0,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textColor,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 13, // تصغير حجم الخط قليلاً
          ),
        ),
      ),
    );
  }
}