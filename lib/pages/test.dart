import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
// import 'fellowship-main/yelp_academic_dataset_business.json';


class Test extends StatefulWidget{
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _Test();
}

class _Test extends State<Test> {
  List _items = [];

  Future<void> readJson() async {
    String response = await DefaultAssetBundle.of(context).loadString('santa_barbara.json');
    final data = await json.decode(response);
    // final jsonResult = jsonDecode(data); //latest Dart
    setState((){
      _items = data["items"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Kindacode.com',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: readJson,
              child: const Text('Load Data'),
            ),

            // Display the data loaded from sample.json
            _items.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return Card(
                    key: ValueKey(_items[index]["id"]),
                    margin: const EdgeInsets.all(10),
                    color: Colors.amber.shade100,
                    child: ListTile(
                      leading: Text(_items[index]["id"]),
                      title: Text(_items[index]["name"]),
                      subtitle: Text(_items[index]["description"]),
                    ),
                  );
                },
              ),
            )
                : Container()
          ],
        ),
      ),
    );
  }
}
