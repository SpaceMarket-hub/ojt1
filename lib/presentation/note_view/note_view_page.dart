import 'package:flutter/material.dart';

import 'package:memojt/domain/model/note.dart';
import 'package:memojt/presentation/note_edit/note_edit_page.dart';
import 'package:memojt/presentation/util/riverpod_provider.dart';

class NoteViewPage extends StatefulWidget {
  const NoteViewPage({Key? key, required this.id}) : super(key: key);
  final int id;
  static const routeName = '/view';

  @override
  State<NoteViewPage> createState() => _NoteViewPageState();
}

class _NoteViewPageState extends State<NoteViewPage> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Note>(
        future: noteDatabase().getNote(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          }
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Err Situation'),
              ),
              body: Center(child: Text('err:${snapshot.error}'),),
            );
          }
          final note = snapshot.requireData;
          return Scaffold(
            appBar: AppBar(
              title: Text(note.title.isEmpty ? 'No_title' : note.title),
              actions: [
                IconButton(onPressed: (){_edit(widget.id);}, icon: const Icon(Icons.edit), tooltip: 'EDIT',),
                IconButton(onPressed: (){_confirmDelete(widget.id);}, icon: const Icon(Icons.delete), tooltip: 'DEL',)
              ],
            ),
            body: SizedBox.expand(
              child: Container(
                color: note.color,
                child: SingleChildScrollView(padding: const EdgeInsets.all(12.0),child: Text(note.body),
                ),
              ),
            ),
          );
        },
    );
  }

  void _edit(int index) {
    Navigator.pushNamed(context, NoteEditPage.routeName, arguments: index).then((_) {
      setState(() {
      });
    });
  }

  void _confirmDelete(int index) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: const Text('DELETE'),
        content: const Text('REAL?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('NO'),
          ),
          TextButton(
            onPressed: () {
              noteDatabase().deleteNote(index);
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: const Text('YES'),
          ),
        ],
      );
    });
  }
}
