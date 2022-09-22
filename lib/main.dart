import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/single_new.dart';

import 'dart_http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Articles? artical;
  bool error = false;

  Future api() async {
    try {
      var res = await http.get(Uri.parse(
          "https://newsapi.org/v2/everything?q=tesla&from=2022-09-22&sortBy=publishedAt&apiKey=0c341da764424524812d2ecfddaf67bc"));
      if(res.statusCode != 200){
        throw Exception();
      }
      setState(() {
        artical = Articles.fromJson(json.decode(res.body));
      });
    } on Exception catch (e) {
      setState(() {
        error= true;
      });
    }
  }
final ScrollController scrollController =ScrollController();
  bool showFAB=false;
  @override
  void initState() {
    api();
    scrollController.addListener(() {
      setState(() {
        showFAB=scrollController.offset>300?true:false;
      });
    });
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text("News App"),
      ),
        body:error== true?

            Center(
              child:Text("Error")
            ): artical == null
            ? const Center(child: CircularProgressIndicator())
            : ListView(
          controller: scrollController,
                children: [
                  ...artical!.articles.map((e) => InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SingleNew(
                                e: e,
                              )));

                    },
                    child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ///img
                              Container(
                                height: 200.0,
                                width: double.infinity,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(e.urlToImage ??
                                          "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.apple.com%2Feg%2F&psig=AOvVaw2OQXfl2oZpZy_iojdynrr0&ust=1663848043767000&source=images&cd=vfe&ved=2ahUKEwimjZKO66X6AhUDhLAFHV3AA50QjRx6BAgAEAs"),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(10),child: Text(
                                  e.title,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500
                                  ),
                              ),)


                              ///title
                            ],
                          ),
                        ),
                  ))
                ],
              ),
      floatingActionButton: showFAB?FloatingActionButton(
          child: Icon(
            Icons.keyboard_arrow_up_sharp,
            size: 30,
          ),
          onPressed: (){
        scrollController.animateTo(0.0, duration: Duration(seconds: 1), curve: Curves.ease);
      }):null,
    );
  }
}
