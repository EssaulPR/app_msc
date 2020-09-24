import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}



Future<List> fetchGeneros() async {
  final response = await http.get('https://binaryjazz.us/wp-json/genrenator/v1/genre/25/');
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load album');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Generador De Generos Musicales'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchGeneros();
    
  }

  void updateForencast(){
    futureAlbum = fetchGeneros();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: FutureBuilder<List>(
              future: futureAlbum,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Tus 6 generos musicales!"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Column( children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(snapshot.data[0]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(snapshot.data[1]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(snapshot.data[2]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(snapshot.data[3]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(snapshot.data[4]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(snapshot.data[5]),
                          ),
                        ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: RaisedButton(
                onPressed: () {
                  updateForencast();
                  },),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            )
        ),
      ),
    );
  }
}
