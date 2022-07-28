import 'package:flutter/material.dart';
import 'package:simple_app_bloc/time_database.dart';
import '../models/time.dart';

import '../note_card_widget.dart';

class HomeScaffold extends StatefulWidget {

  @override
  State<HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  List<Time> times;
  bool isLoading = false;

  @override
  void initState(){
    super.initState();

    refreshTime();
  }

  @override
  void dispose() {
    TimeDatabase.instance.close();

    super.dispose();
  }

  Future refreshTime() async{
    setState(() => isLoading = true);
    this.times = await TimeDatabase.instance.readTime();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Login Time'),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : times?.isEmpty ?? true
            ? Text(
          'No Notes',
          style: TextStyle(color: Colors.black, fontSize: 24),
        )
            : buildNotes(),
      ),
    );
  }
  Widget buildNotes() => ListView.builder(
    itemCount: times.length,
    itemBuilder: (context, index) {
      final time2 = times[index];

      return GestureDetector(
        onTap: () async {
          refreshTime();
        },
        child: NoteCardWidget(time: time2, index: index),
      );
    },
  );
}
