import 'package:flutter/material.dart';

class AppAlertDialog extends StatelessWidget {
  final String title;
  final Widget? content;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final Color? backgroundColor;

  const AppAlertDialog({
    super.key,
    required this.title,
    this.content,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor ?? Colors.white,
      title: Text(title),
      content: content,
      actions: [
        if (cancelText != null)
          TextButton(
            onPressed: onCancel ?? () => Navigator.pop(context),
            child: Text(cancelText!),
          ),
        if (confirmText != null)
          ElevatedButton(
            onPressed: onConfirm,
            child: Text(confirmText!),
          ),
      ],
    );
  }
}
