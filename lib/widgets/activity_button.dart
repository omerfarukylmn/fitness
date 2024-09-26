import 'package:flutter/material.dart';

class ActivityButton extends StatelessWidget {
  final String activity;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onSelect;

  const ActivityButton({super.key, 
    required this.activity,
    required this.icon,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onSelect,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.green : Colors.grey[700],
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(
            color: isSelected ? Colors.greenAccent : Colors.transparent,
            width: 2,
          ),
        ),
        fixedSize: const Size(140, 140),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 40,
          ),
          const SizedBox(height: 8),
          Text(
            activity,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}