import 'package:flutter/material.dart';

class NoteSettings extends StatelessWidget {
  final void Function()? onEditPresses;
  final void Function()? onDeletePressed;
  const NoteSettings({super.key,required this.onDeletePressed, required this.onEditPresses});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // edit option
        GestureDetector(
          onTap: onEditPresses,
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.surface,
            child: Text('Edit'),
          ),
        ),

        GestureDetector(
          onTap: onDeletePressed,
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.surface,
            child: Text('Delete'),
          ),
        )
      ],
    );
  }
}
