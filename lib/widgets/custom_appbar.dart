import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title; // String başlık (Opsiyonel yaptık)
  final Widget? titleWidget; // Widget başlık (Arama kutusu için)
  final bool centerTitle;
  final List<Widget>? actions; // Sağ taraftaki butonlar için

  const CustomAppbar({
    super.key,
    this.title, 
    this.titleWidget,
    this.centerTitle = true,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Eğer titleWidget (arama kutusu) varsa onu koy, yoksa Text(title) koy
      title: titleWidget ?? Text(title ?? ""), 
      centerTitle: centerTitle,
      actions: actions,
      backgroundColor: Colors.orange, // Sabit renk (İstersen parametre yapabilirsin)
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}