import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fellowship/pages/place_staggered_gridview.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:fellowship/pages/another_test.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fellowship/pages/cardswipe_page.dart';
import 'package:fellowship/pages/main_home.dart';

const double _kCurveHeight = 35;

class ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Path();
    var rect = Offset.zero & size;
    p.lineTo(0, size.height - _kCurveHeight);
    p.relativeQuadraticBezierTo(size.width / 2, 2 * _kCurveHeight, size.width, 0);
    p.lineTo(size.width, 0);
    p.close();

    canvas.drawPath(p, Paint()..shader = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        Color.fromARGB(255, 16, 59, 33),
        Colors.white,
      ],
    ).createShader(rect));

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class SearchPage extends StatefulWidget {
    const SearchPage({Key? key}) : super(key: key);
    
    @override
    _SearchPage createState() => _SearchPage();
}

class city{
  static List<String> cities = [
    "New Orleans", "Philadelphia", "Reno", "Santa Barbara",
  ];

  static List<String> getSuggestions(String query) =>
      List.of(cities).where((city) {
        final cityLower = city.toLowerCase();
        final queryLower = query.toLowerCase();

        return cityLower.contains(queryLower);
      }).toList();
}
class _SearchPage extends State<SearchPage> {
  final controllerCity = TextEditingController();

  final categoryList = [
     'Surprise me!',
     'New Cuisine',
     'Beach trip',
     'Mountain escape',
     'Indoor Adventure',
     ];
     int currentSelected = 0;
 @override
  Widget build(BuildContext context) {
     return 
     Scaffold(
       backgroundColor: Colors.white,
       body: Container(
         child: Stack(
           children: [
             Container(
               child: CustomPaint(
                 painter: ShapesPainter(),
                 child: Container(height: 300),
               ),
             ),
             Column(
            crossAxisAlignment: CrossAxisAlignment.start,
             children: [
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 75),
                child: Text(
                    "Select your location &",
                    style: TextStyle(fontSize: 25),
                  ),
              ),
                Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Explore",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
               buildCity(),
               Center(
                 child: OutlinedButton(
                   onPressed: () {
                   Navigator.pushReplacement(
                       context, MaterialPageRoute(builder: (_) => MainHome()));
                   },
                   style: OutlinedButton.styleFrom(
                       backgroundColor: Colors.teal[1200]
                   ),
                   child: const Text("Go", style: TextStyle(color: Colors.white)),
                 ),
               ),
               Container(
                 padding: EdgeInsets.symmetric(horizontal: 20),
                 height: 20,
                 child: ListView.separated(
                   scrollDirection: Axis.horizontal,
                   itemBuilder: (context, index) => GestureDetector(
                     onTap: () {
                       setState(() {
                         currentSelected = index;
                       });
                     },
                     child: Container(
                       child: Text(
                        categoryList[index],
                       style: TextStyle(
                         fontSize: 16,
                         fontWeight: currentSelected == index
                         ? FontWeight.bold
                         : FontWeight.w500,
                         color: currentSelected == Colors.white
                         ? Theme.of(context).primaryColor : Colors.grey,
                       ),
                       ),
                     ),
                   ) ,
                   separatorBuilder: (_, index) => SizedBox(width: 20),
                   itemCount: categoryList.length,
                   )
               ),
               SizedBox(height: 20),
                   SingleChildScrollView(
                     scrollDirection: Axis.horizontal,
                     padding: const EdgeInsets.all(12),
                     child: Row(
                       children: [
                         GestureDetector(
                             onTap: () {
                              Navigator.pushReplacement(
                                  context, MaterialPageRoute(builder: (_) => MainHome()));
                              },
                             child: MySquare('Reno', 'assets/reno.jpg')
                         ),
                         const SizedBox(width:12),
                         GestureDetector(
                             onTap: () {
                               Navigator.pushReplacement(
                                   context, MaterialPageRoute(builder: (_) => MainHome()));
                             },
                             child: MySquare('Philadelphia', 'assets/philadelphia.jpg')
                         ),
                         const SizedBox(width:12),
                         GestureDetector(
                             onTap: () {
                               Navigator.pushReplacement(
                                   context, MaterialPageRoute(builder: (_) => MainHome()));
                             },
                             child: MySquare('New Orleans', 'assets/new_orleans.jpg')
                         ),
                         const SizedBox(width:12),
                         GestureDetector(
                             onTap: () {
                               Navigator.pushReplacement(
                                   context, MaterialPageRoute(builder: (_) => MainHome()));
                             },
                             child: MySquare('Santa Barbara', 'assets/santa_barbara.jpg')),
                         const SizedBox(width:12),
                       ],
                     )
                   )
               ],
           ),
         ]),
       ),
     );

   }
  Widget buildCity() =>
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TypeAheadFormField<String?>(
    textFieldConfiguration: TextFieldConfiguration(
        controller: controllerCity,
        decoration: InputDecoration(
          labelText: 'Where do you want to go?',
          border: OutlineInputBorder(),
        )
    ),
    suggestionsCallback: city.getSuggestions,
    itemBuilder: (context, String? suggestion) => ListTile(
          title: Text(suggestion!)
    ),
    onSuggestionSelected: (String? suggestion) =>
    controllerCity.text = suggestion!,
  ),
      );

}

Widget SearchInput() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0,3))
          ]),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Container(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.search
            ),
          ),
          border: InputBorder.none,
          hintText: 'Where do you want to go?'
        ),
         ),
      );
  }





