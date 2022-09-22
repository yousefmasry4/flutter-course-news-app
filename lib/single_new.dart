import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart_http.dart';

class SingleNew extends StatelessWidget {
  final Article e;

  const SingleNew({super.key, required this.e});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(e.title),
      ),
      body: ListView(
        children: [
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
          Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                e.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: 20,
          ),
          Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                e.description,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              )),
        ],
      ),
    );
  }
}
