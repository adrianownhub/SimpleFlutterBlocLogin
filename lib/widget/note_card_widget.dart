import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/time.dart';


class NoteCardWidget extends StatelessWidget {
  NoteCardWidget({
    Key key,
    @required this.time,
    @required this.index,
  }) : super(key: key);

  final Time time;
  final int index;

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String date = dateFormat.format(time.createdTime);

    return ListTile(
        leading: const Icon(Icons.list),
        trailing: Text(
          date,
          style: TextStyle(color: Colors.black, fontSize: 12),
        ),
        title: Text(time.email));
  }

  /// To return different height for different widgets
  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}