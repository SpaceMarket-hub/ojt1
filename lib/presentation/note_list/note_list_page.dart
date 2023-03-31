import 'package:flutter/material.dart';
import 'package:memojt/presentation/note_edit/note_edit_page.dart';
import 'package:memojt/presentation/note_view/note_view_page.dart';
import 'package:memojt/presentation/util/riverpod_provider.dart';

import '../../domain/model/note.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memo App'),
        backgroundColor: Colors.cyan,
      ),
      body: FutureBuilder<List<Note>>(
        future: noteDatabase().listNotes(),
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
          final notes = snapshot.requireData;
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1,),
              padding: const EdgeInsets.all(12.0),
              itemCount: notes.length,
              itemBuilder: (BuildContext context, int index) => _buildCard(notes[index]));
        },
      ),
      floatingActionButton: FloatingActionButton(tooltip: 'new', onPressed: () {
        Navigator.pushNamed(context, NoteEditPage.routeName).then((_){setState(() {});
        });
      },),
    );
  }

  Widget _buildCard(Note note) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, NoteViewPage.routeName, arguments: note.id).then((_) { setState(() {
        });});
      },
      child: Card(
        color: note.color,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title.isEmpty ? 'No_title' : note.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16,),
              Expanded(child: Text(note.body, overflow: TextOverflow.fade,)),
            ],
          ),
        ),
      ),
    );
  }
}
