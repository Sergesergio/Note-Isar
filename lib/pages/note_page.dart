import 'package:flutter/material.dart';
import 'package:local/modules/note.dart';
import 'package:local/modules/note_db.dart';
import 'package:provider/provider.dart';

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
    final noteDatabase = context.watch<NoteDataBase>();

    //create list of note
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Notepage')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: Createnote,
        child:  const Icon(Icons.add),
      ),
      body:ListView.builder(
        itemCount: currentNotes.length,
          itemBuilder: (context, index) {
          //get individual note
            final note = currentNotes[index];

            //list tile UI
            return ListTile(
              title: Text(note.text),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //edit button
                  IconButton(
                      onPressed: () => updateNote(note),
                      icon:const Icon(Icons.edit),
                  ),
                  IconButton(
                      onPressed:() => deleteNote(note.id),
                      icon:const Icon(Icons.delete)
                  )
                ],
              ),
            );
          }
      ),
    );
  }
}
