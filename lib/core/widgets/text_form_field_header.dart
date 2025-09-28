import 'package:flutter/material.dart';

class TextFormFieldHeader extends StatelessWidget {
  final String title;
  const TextFormFieldHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ],
      ),
    );
  }
}
