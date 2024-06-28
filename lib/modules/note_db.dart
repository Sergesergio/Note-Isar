
import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:offline_isar/modules/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDataBase extends ChangeNotifier{
  static late Isar isar;

  // initialize db
  static Future<void> initialize() async{
    final dir = await getApplicationCacheDirectory();
    isar = await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
  }
// list note
  final List<Note> currentNotes = [];

  // create
  Future<void> addNote(String textFromUser) async {

    //create new note object
    final newNote = Note()..text  = textFromUser;

    // save to db
    await isar.writeTxn(() => isar.notes.put(newNote));

    //re-read from db
    fetchNotes();
  }
  //read note from db
  Future<void> fetchNotes() async{
    List<Note> fetchNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchNotes);
    notifyListeners();
  }
// update
  Future<void> updateNote (int id, String newText) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null){
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
      // notifyListeners();
    }
  }
  //delete
  Future<void> deleteNote(int id) async{
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
    // notifyListeners();
  }

}