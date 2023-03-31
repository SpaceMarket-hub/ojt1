import 'package:flutter/material.dart';

class Note {
  static const colorDefault = Colors.white;
  static const colorPink = Color(0xFFFFCDD2);
  static const colorApri = Color(0xFFFFE0b2);
  static const colorCoPl = Color(0xFFFFF9c4);
  static const colorLime = Color(0xFFF0F4C3);
  static const colorBlue = Color(0xFFBBDEFB);

  final int? id;
  final String title;
  final String body;
  final Color color;
  //final DateTime date;

  // Note({ this.title = '', this.body = '', this.color = colorDefault, DateTime? date }) : this.date = date ?? DateTime.now();
  Note(this.body, {this.id, this.title = '', this.color = colorDefault});

  final Note notes = Note('40,1B');

  static const tableName = 'notes';
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnBody = 'body';
  static const columnColor = 'color';

  Note.fromRow(Map<String, dynamic> row)
    : this(
    row[columnBody],
    id: row[columnId],
    title: row[columnTitle],
    color: Color(row[columnColor]), //
  );

  Map<String, dynamic> toRow() {
    return {
      columnTitle: title,
      columnBody: body,
      columnColor: color.value, //
    };
  }
}