import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import './location_screen.dart';

class HomeScreen extends StatelessWidget {
  static final String routeName = '/homescreen';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final String locationText =
        (ModalRoute.of(context).settings.arguments) ?? '';

    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
                child: InputDecorator(
                    child: Text(locationText ?? 'Click to select location'),
                    decoration: InputDecoration(
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))))),
                onTap: () => Navigator.of(context)
                    .pushReplacementNamed(LocationScreen.routeName)),
          ),
          Divider(),
          ClipRect(
            child: Container(
              width: double.infinity,
              height: 300,
              child: Stack(children: [
                Container(
                    decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/veg.png'),
                      fit: BoxFit.cover),
                )),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(color: Colors.black.withOpacity(0)),
                ),
                Positioned(
                    top: 10,
                    left: 10,
                    child: Text('K.',
                        style: Theme.of(context).textTheme.headline3.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white))),
                Positioned(
                    top: 110,
                    left: 10,
                    child: Container(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 60.0,
                          maxWidth: width * 0.7,
                          minHeight: 30.0,
                          maxHeight: 100.0,
                        ),
                        child: AutoSizeText(
                          "Want fresh tasty food delivered to you?",
                          style: TextStyle(fontSize: 30.0, color: Colors.white),
                        ),
                      ),
                    )),
              ]),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 2),
              child: Text('Categories',
                  style: Theme.of(context).textTheme.headline5)),
          Container(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, i) => Padding(
                padding: EdgeInsets.only(right: 10),
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/veg.png'))),
                  child: Center(child: Text('Category')),
                ),
              ),
              itemCount: 16,
            ),
          ),
        ],
      )),
    );
  }
}
