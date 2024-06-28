import 'package:flutter/material.dart';
import 'package:offline_isar/modules/note_db.dart';
import 'package:offline_isar/pages/note_page.dart';
import 'package:offline_isar/theme/theme_provider.dart';
import 'package:provider/provider.dart';


void main() async{
  //initialize note isar db
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDataBase.initialize();

  runApp(
    MultiProvider(
      providers: [
        //note provider
        ChangeNotifierProvider(create: (context) => NoteDataBase()),
        //theme provider
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child:const  MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}

