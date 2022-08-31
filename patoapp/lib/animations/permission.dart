import 'package:flutter/material.dart';

permissionDenied(BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Permission Denied"),
    ),
  );
}
