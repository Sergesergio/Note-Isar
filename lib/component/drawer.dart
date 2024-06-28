import 'package:flutter/material.dart';
import 'package:offline_isar/component/drawer_tile.dart';
import 'package:offline_isar/pages/settings.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          //header
          DrawerHeader(
              child: Icon(Icons.note),
          ),
          // note tile
          DrawerTile(
              leading: Icon(Icons.home),
              title: "Note",
              onTap:() => Navigator.pop(context)
          ),

          //setting
          DrawerTile(
              leading: Icon(Icons.settings),
              title: "Setting",
              onTap:() {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder:(context) => Settings()
                  )

                );
              }
          )

        ],
      ),
    );
  }
}
