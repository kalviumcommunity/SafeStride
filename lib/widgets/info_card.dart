import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;
  final Color? iconColor;
  final double? iconSize;
  final EdgeInsets? margin;
  final double? elevation;

  const InfoCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
    this.iconColor,
    this.iconSize,
    this.margin,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin ?? const EdgeInsets.all(12),
      elevation: elevation ?? 4,
      child: ListTile(
        leading: Icon(
          icon,
          color: iconColor ?? Colors.teal,
          size: iconSize ?? 32,
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }
}
