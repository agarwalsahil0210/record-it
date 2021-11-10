import 'dart:io';
import 'package:zorp_assignment/model/media_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:zorp_assignment/recordAudioPage.dart';
import 'package:zorp_assignment/PlayVideoPage.dart';
import 'package:zorp_assignment/widgets/camera_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late File fileMedia = null as File;
  late MediaSource source;
  List _items = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    setState(() {
      _items = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    readJson();
    return Scaffold(
      appBar: AppBar(
        title: Text('ZORP'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            // ? Column(children: [
            //     SizedBox(height: 20),
            Container(
                child: fileMedia != null ? RecordVideoPage(fileMedia) : null,
                // width: 300,
                height: 300),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ExpansionTile(
                      leading: Icon(_items[index]["type"] == "VIDEO"
                          ? Icons.video_call
                          : Icons.audiotrack),
                      title: Text(_items[index]["type"] == "VIDEO"
                          ? "Record Video"
                          : "Record Audio"),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          _items[index]["type"] == "VIDEO"
                              ? capture(MediaSource.image)
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RecordAudioPage(),
                                  ),
                                );
                        },
                      ),
                      // subtitle: Text(_items[index]["maxLengthInSeconds"]),
                      // children: <Widget>[
                      //   Center(
                      //       child: ListTile(
                      //     trailing:
                      //   ))
                      // ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                // if (_formKey.currentState!.validate()) {
                //   // If the form is valid, display a snackbar. In the real world,
                //   // you'd often call a server or save the information in a database.
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(content: Text('Processing Data')),
                // );
              },
              // },
              child: const Text('Submit'),
            ),

            // ],)
          ],
        ),
      ),
    );
  }

  Future capture(MediaSource source) async {
    setState(() {
      this.source = source;
      this.fileMedia = null as File;
    });

    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CameraButtonWidget(),
      ),
    );

    if (result == null) {
      return;
    } else {
      setState(() {
        fileMedia = result;
      });
    }
  }
}
