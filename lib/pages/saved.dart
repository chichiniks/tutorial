import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fellowship/Data/catagories.dart';
import 'package:fellowship/pages/another_test.dart';
// import 'package:multi_select_flutter/multi_select_flutter.dart';


class SavedPage extends StatefulWidget {
  final Stream<QuerySnapshot> Qchoices = FirebaseFirestore.instance.collection('Qchoices').snapshots();
  @override
  _SavedPageState createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage>{
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      //initialIndex: 1,
        length:4,
        child: Scaffold(  //used to be return new
            backgroundColor: Colors.white,//Colors.brown[100],
            appBar:AppBar(
              backgroundColor: Colors.teal[900],
              leading: IconButton (
                  icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                  onPressed: () {}),
              title: Text("Saved Locations"),
              actions: <Widget> [
                IconButton(
                    icon: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                    onPressed: () {}
                )
              ],
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.bike_scooter_outlined , color: Colors.white),
                    text: "New Orleans",
                  ),
                  Tab(
                    icon: Icon(Icons.beach_access , color: Colors.white),
                    text: "Reno",
                  ),
                  Tab(
                    icon: Icon(Icons.dinner_dining , color: Colors.white),
                    text: "Philadelphia",
                  ),
                  Tab(
                    icon: Icon(Icons.coffee_sharp , color: Colors.white),
                    text: "Santa Barbara",
                  ),
                ],
              ),
            ),
            body: TabBarView (  //used to be Column
                children: <Widget> [
                  // SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.only(top: 10, left:8.0),
                      child: Align (
                          alignment: Alignment.topLeft,
                          child: Container(
                              child: Wrap(
                                  spacing: 5.0,
                                  runSpacing: 3.0,
                                  children: <Widget>[
                                    // inside tab
                                    MySaveSquare("Eat Mah Taco", "assets/eat_mah.jpg"),
                                  ]
                              )
                          )
                      )
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10, left:8.0),
                      child: Align (
                          alignment: Alignment.topLeft,
                          child: Container(
                              child: Wrap(
                                  spacing: 5.0,
                                  runSpacing: 3.0,
                                  children: <Widget>[
                                    MySaveSquare("The Office", "assets/office.jpg"),
                                    MySaveSquare("Mount Mogrit Gourmet", "assets/mmg.jpg")
                                    // MySaveSquare(title, "assets/")
                                    // inside tab
                                  ]
                              )
                          )
                      )
                  ),  //,
                  Padding(
                      padding: const EdgeInsets.only(top: 10, left:8.0),
                      child: Align (
                          alignment: Alignment.topLeft,
                          child: Container(
                              child: Wrap(
                                  spacing: 5.0,
                                  runSpacing: 3.0,
                                  children: <Widget>[
                                    // inside tab
                                    MySaveSquare("Brown Chicken Brown Cow", "assets/bcbc.png")
                                  ]
                              )
                          )
                      )
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10, left:8.0),
                      child: Align (
                          alignment: Alignment.topLeft,
                          child: Container(
                              child: Wrap(
                                  spacing: 5.0,
                                  runSpacing: 3.0,
                                  children: <Widget>[
                                    MySaveSquare("Ascending Health Juicery", "assets/ahj.jpg")
                                    // inside tab
                                  ]
                              )
                          )
                      )
                  ),
                ]
            )
        )
    );
  }
}

@override
State<StatefulWidget> createState() {
  // TODO: implement createState
  throw UnimplementedError();
}

Widget _titleContainer (String myTitle){
  return Text(
    myTitle,
    style: TextStyle(
        color: Colors.deepPurple, fontSize: 24.0, fontWeight: FontWeight.bold),
  );
}