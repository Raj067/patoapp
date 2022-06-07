import 'package:flutter/material.dart';

Widget customTile(Icon leadingIcon, Text content, Function onTap) {
  return Card(
    child: InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            leadingIcon,
            Container(
              width: 10,
            ),
            content,
          ],
        ),
      ),
    ),
  );
}
