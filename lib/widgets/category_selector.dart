// lib/widgets/category_selector.dart
import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final String selected;
  final List<String> categories;
  final ValueChanged<String> onSelected;

  const CategorySelector({
    super.key,
    required this.selected,
    required this.categories,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, i) {
          final cat = categories[i];
          final isActive = cat == selected;
          return GestureDetector(
            onTap: () => onSelected(cat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF6E4AE2) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isActive ? Colors.transparent : Colors.grey.shade300),
                boxShadow: isActive ? [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0,2))] : [],
              ),
              child: Center(
                child: Text(
                  cat,
                  style: TextStyle(
                    color: isActive ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
