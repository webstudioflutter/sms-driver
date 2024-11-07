import 'package:flutter/material.dart';

class PageTitleBar extends StatelessWidget {
  final String? title;
  final IconData? firstIcon;
  final VoidCallback? firstIconAction;
  final VoidCallback? lastIconAction;
  final Widget
      lastWidget; // The last widget can be an icon or anything you want.

  const PageTitleBar({
    super.key,
    this.title, // Title passed as a parameter
    this.firstIcon =
        Icons.arrow_back, // Default icon for the first button (back button)
    this.lastIconAction,
    this.firstIconAction, // Action for the first icon (optional)
    this.lastWidget = const Icon(Icons
        .notifications_active_outlined), // Default last widget (notification icon)
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50, // Height of the container
        width: MediaQuery.of(context).size.width *
            0.9, // Adjust width as per screen size
        decoration: const BoxDecoration(
          color: Color(0xffcdeede),
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Row(
          children: [
            // First Icon (back button or custom icon)
            IconButton(
              onPressed: firstIconAction ??
                  () => Navigator.pop(
                      context), // Default action is to pop the page
              icon: Icon(firstIcon),
            ),
            const Spacer(), // Adds space between the widgets
            // Title Text
            Align(
              alignment: Alignment.center,
              child: Text(
                title ?? "",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Spacer(), // Adds space between the title and last widget
            // Last Widget (e.g., notification icon)
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: lastWidget,
            ),
          ],
        ),
      ),
    );
  }
}
