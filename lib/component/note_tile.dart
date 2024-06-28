import 'package:flutter/material.dart';
import 'package:offline_isar/component/note_settings.dart';
import 'package:popover/popover.dart';

class NoteTile extends StatelessWidget {
  final String text;
  final void Function()? onEditPress;
  final void Function()?  onDeletePress;

  const NoteTile({
    super.key,
    required this.text,
    required this.onEditPress,
    required this.onDeletePress
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(top: 10, left: 18, right: 20),
      child: ListTile(
        title: Text(text),
        trailing: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () => showPopover(
                width:100 ,
                  height: 100,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  context: context,
                  bodyBuilder: (context) => NoteSettings(
                  ),
              ),
            );
          }
        )
      ),
    );
  }
}
// Row(
// mainAxisSize: MainAxisSize.min,
// children: [
// IconButton(
// onPressed: onEditPress,
// icon: Icon(Icons.edit),
// ),
// IconButton(
// onPressed: onDeletePress,
// icon: Icon(Icons.delete),
// )
// ],
//
// ),