import 'package:flutter/material.dart';
import 'package:local/modules/note_db.dart';
import 'package:local/pages/note_page.dart';
import 'package:provider/provider.dart';

void main() async{
  //initialize note isar db
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDataBase.initialize();

  runApp(
    ChangeNotifierProvider(
        create: (context) => NoteDataBase(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotePage(),
    );
  }
}
