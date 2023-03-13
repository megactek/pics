// Import flutter helper library
import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'models/image_model.dart';
import 'dart:convert' show json;
import 'widgets/image_list.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

// create class that would be custom widget
class AppState extends State<App> {
  int counter = 0;
  List<ImageModel> rawImages = [];
  void fetchImage() async {
    counter++;
    var url = Uri.https('jsonplaceholder.typicode.com', 'photos/$counter');
    var response = await get(url);
    var imageModel = ImageModel.fromJson(json.decode(response.body));
    setState(() {
      rawImages.add(imageModel);
    });
  }

  @override
  Widget build(context) {
    return MaterialApp(
        home: Scaffold(
      body: ImageList(rawImages),
      appBar: AppBar(
        title: Text("Let's see some images!"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: fetchImage,
      ),
    ));
  }
}
