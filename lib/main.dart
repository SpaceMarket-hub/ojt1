import 'package:flutter/material.dart';
import 'package:memojt/presentation/note_edit/note_edit_page.dart';
import 'package:memojt/presentation/note_list/note_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feature Flags Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,),
      initialRoute: NoteListPage.routeName,
      routes: {
        NoteListPage.routeName: (context) => const NoteListPage(),
        NoteEditPage.routeName: (context) { // => const NoteEditPage(),
          final args = ModalRoute.of(context)!.settings.arguments;
          final id = args != null ? args as int : null;
          return NoteEditPage(id: id,);
        }
      },
    );
  }
}
