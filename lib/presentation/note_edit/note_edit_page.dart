import 'package:flutter/material.dart';
import 'package:memojt/presentation/util/riverpod_provider.dart';

import '../../domain/model/note.dart';

class NoteEditPage extends StatefulWidget {
  const NoteEditPage({Key? key, this.id}) : super(key: key);
  static const routeName = '/edit';
  final int? id;

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  Color memoColor = Note.colorDefault;

  void _displayColorSelectionDialog() {
    FocusManager.instance.primaryFocus!.unfocus();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Background Color?'),
          content: Column(mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(title: Text('NoColor'), onTap: () =>_applyColor(Note.colorDefault),),
              ListTile(title: Text('Apricot'), onTap: () =>_applyColor(Note.colorApri),),
              ListTile(title: Text('Blue'), onTap: () =>_applyColor(Note.colorBlue),),
              ListTile(title: Text('Copl'), onTap: () =>_applyColor(Note.colorCoPl),),
              ListTile(title: Text('Lime'), onTap: () =>_applyColor(Note.colorLime),),
              ListTile(title: Text('Pink'), onTap: () =>_applyColor(Note.colorPink),),
            ],
          ),
        );
      },
    );
  }

  void _applyColor(Color changeColor) {
    setState(() {
      Navigator.pop(context);
      memoColor = changeColor;
    });
  }

  void _saveNote() {
    if (bodyController.text.isNotEmpty) {
      final note = Note(
        bodyController.text,
        title: titleController.text,
        color: memoColor,
      );
      final noteIndex = widget.id; // widget == NoteEditPage
      if (noteIndex != null) {
        noteDatabase().updateNote(noteIndex, note);
      } else {
        noteDatabase().addNote(note);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("not to permit empty"),
          behavior: SnackBarBehavior.floating,
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'), backgroundColor: Colors.lightBlue,
        actions: [
          IconButton(onPressed: _displayColorSelectionDialog, icon: const Icon(Icons.color_lens), tooltip: 'B.G.C. choice',),
          IconButton(onPressed: _saveNote, icon: const Icon(Icons.save), tooltip: 'SAVE',)
        ],
      ),
      body: SizedBox.expand(
        child: Container(
          color: memoColor,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Input title')
                  ),
                  maxLines: 1,
                  style: const TextStyle(fontSize: 20),
                  controller: titleController,
                ),
                const SizedBox(height: 8,),
                TextField(
                  decoration: InputDecoration(border: InputBorder.none, hintText: 'Input Contents'),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: bodyController,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
