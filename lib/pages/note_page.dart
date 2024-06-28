import 'package:flutter/material.dart';
import 'package:offline_isar/component/drawer.dart';
import 'package:offline_isar/component/note_tile.dart';
import 'package:offline_isar/modules/note.dart';
import 'package:provider/provider.dart';
import '../modules/note_db.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  //text controller to access what the user type
  final textController = TextEditingController();

  @override
  void initState() {
    readNotes();
    // TODO: implement initState
    super.initState();
  }
  // Create a note
  void Createnote(){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: TextField(
            controller: textController,
          ),
          actions: [
            //button
            MaterialButton(
              onPressed: () {
                // add to db
                context.read<NoteDataBase>().addNote(textController.text);
                //clear controller
                textController.clear();
                // dismiss box when clicked create
                Navigator.pop(context);
              },
              child: const Text("Create"),
            )
          ],
        )
    );
  }

  //read a note
  void readNotes(){
    context.read()<NoteDataBase>().fetchNotes();
  }

  //update a note
  void updateNote(Note note){
    //pre-fill the current note
    textController.text = note.text;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title:const Text("Update Note"),
          content: TextField(controller: textController,),
          actions: [
            //update button
            MaterialButton(
              onPressed: (){
                //update note db
                context.read<NoteDataBase>().updateNote(note.id, textController.text);
                //clear controller
                textController.clear();
                //pop dialog
                Navigator.pop(context);
              },
              child: const Text('Update'),
            )
          ],
        )
    );
  }

  //delete note
  void deleteNote(int id){
    context.read<NoteDataBase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    // note db
    final noteDatabase = context.watch<NoteDataBase>();

    //create list of note
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        title:const Center(child: Text('Notepage')),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: Createnote,
        child: Icon(Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      drawer:MyDrawer(),
      body:ListView.builder(
          itemCount: currentNotes.length,
          itemBuilder: (context, index) {
            //get individual note
            final note = currentNotes[index];

            //list tile UI
            return NoteTile(
                text: note.text,
              onEditPress: () => updateNote(note),
              onDeletePress: () => deleteNote(note.id),
            );
          }
      ),
    );
  }
}
