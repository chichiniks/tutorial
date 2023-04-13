import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fellowship/Data/catagories.dart';
import 'package:fellowship/pages/main_home.dart';
// import 'package:multi_select_flutter/multi_select_flutter.dart';

class FilterChipDisplay extends StatefulWidget {
  @override
  _FilterChipDisplayState createState() => _FilterChipDisplayState();
}

class _FilterChipDisplayState extends State<FilterChipDisplay>{
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      //initialIndex: 1,
        length:4,
        child: Scaffold(  //used to be return new
            backgroundColor: Colors.brown[100],
            appBar:AppBar(
              backgroundColor: Colors.teal[900],
              leading: IconButton (
                  icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                  onPressed: () {}),
              title: Text("Activity Finder"),
              actions: <Widget> [
                IconButton(
                    icon: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => MainHome()));

                    }
                )
              ],
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.bike_scooter_outlined , color: Colors.white),
                    text: "Adventure",
                  ),
                  Tab(
                    icon: Icon(Icons.beach_access , color: Colors.white),
                    text: "Relax",
                  ),
                  Tab(
                    icon: Icon(Icons.dinner_dining , color: Colors.white),
                    text: "Eat",
                  ),
                  Tab(
                    icon: Icon(Icons.coffee_sharp , color: Colors.white),
                    text: "Drink",
                  ),
                ],
              ),
            ),
            body: TabBarView (  //used to be Column
                children: <Widget> [
                  /*Align (
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _titleContainer("What would you like to do?"),
              ),
            ),*/
                  Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Align (
                          alignment: Alignment.topCenter,
                          child: Container(
                              child: Wrap(
                                  spacing: 5.0,
                                  runSpacing: 3.0,
                                  children: <Widget>[
                                    filterChipWidget(chipName: "Water Sports"),
                                    filterChipWidget(chipName: "Land Sports"),
                                    filterChipWidget(chipName: "Sightseeing"),
                                    filterChipWidget(chipName: "Hiking"),
                                    filterChipWidget(chipName: "Beach"),
                                    filterChipWidget(chipName: "Mountain"),
                                    filterChipWidget(chipName: "Camping"),
                                  ]
                              )
                          )
                      )
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Align (
                          alignment: Alignment.topCenter,
                          child: Container(
                              child: Wrap(
                                  spacing: 5.0,
                                  runSpacing: 3.0,
                                  children: <Widget>[
                                    filterChipWidget(chipName: "Parks"),
                                    filterChipWidget(chipName: "Shopping"),
                                    filterChipWidget(chipName: "Museums and Exhibits"),
                                    filterChipWidget(chipName: "Sightseeing"),
                                    filterChipWidget(chipName: "Create Art"),
                                  ]
                              )
                          )
                      )
                  ),  //,
                  Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Align (
                          alignment: Alignment.topCenter,
                          child: Container(
                              child: Wrap(
                                  spacing: 5.0,
                                  runSpacing: 3.0,
                                  children: <Widget>[
                                    filterChipWidget(chipName: "Italian"),
                                    filterChipWidget(chipName: "Japanese"),
                                    filterChipWidget(chipName: "American"),
                                    filterChipWidget(chipName: "Fast Food"),
                                    filterChipWidget(chipName: "Cafe"),
                                  ]
                              )
                          )
                      )
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Align (
                          alignment: Alignment.topCenter,
                          child: Container(
                              child: Wrap(
                                  spacing: 5.0,
                                  runSpacing: 3.0,
                                  children: <Widget>[
                                    filterChipWidget(chipName: "Coffee"),
                                    filterChipWidget(chipName: "Alcohol (21+)"),
                                    filterChipWidget(chipName: "Boba"),
                                    filterChipWidget(chipName: "Smoothies"),
                                    filterChipWidget(chipName: "Juice"),
                                  ]
                              )
                          )
                      )
                  )
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

class filterChipWidget extends StatefulWidget {
  final String chipName;

  filterChipWidget({Key? key, required this.chipName}) : super(key:key);
  @override
  _filterChipWidgetState createState() => _filterChipWidgetState();
}

class _filterChipWidgetState extends State<filterChipWidget>{
  var _isSelected = false;
  @override
  Widget build(BuildContext context){
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold),
      selected: _isSelected,
      backgroundColor: Colors.white,
      onSelected: (isSelected){
        setState( () {
          _isSelected = isSelected;
        });
      },
      selectedColor: Colors.teal[800],
    );
  }
}