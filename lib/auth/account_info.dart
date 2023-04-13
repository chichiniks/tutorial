import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


// UI
class AccountInfo extends StatelessWidget {
  final Stream<QuerySnapshot> users = FirebaseFirestore.instance.collection('users').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Account Information'),),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Please Enter Your Account Information',
                    style: TextStyle(fontSize: 20),
                  ),
                  MyCustomForm()
                  /*Text(
                    'Read Data from Cloud Firestore',
                    style: TextStyle(fontSize: 20),
                  ),
                  Container(
                    height: 250,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child:
                      StreamBuilder<QuerySnapshot>(stream: users, builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something Went Wrong');
                        }
                        if (snapshot.connectionState == ConnectionState.waiting){
                          return Text('Loading..');
                        }
                        final data = snapshot.requireData;
                        return ListView.builder(
                          itemCount: data.size,
                          itemBuilder: (context, index){
                            return Text('My name is ${data.docs[index]['Name']} and I am born in year ${data.docs[index]['Birth Year']}');
                          },
                        );
                      }
                  )
                  )*/
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

class MyCustomForm extends StatefulWidget{
  @override
  /*MyCustomFormState createState() {
      return MyCustomFormState();
  }*/
  State<MyCustomForm> createState() => _MyCustomFormState();
}


class _MyCustomFormState extends State<MyCustomForm> {
    final _formKey = GlobalKey<FormState>();

    var firstname='';
    var lastname='';
    var birthyear = '';
    var email ='';

    @override
    Widget build(BuildContext context){
      //final databaseReference = FirebaseFirestore.instance;
      //CollectionReference users = FirebaseFirestore.instance.collection('users').document('user1').collection('accountInfo').setData({});
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: "Please Enter Your Name",
                labelText: 'First Name',
              ),
              onChanged: (value) {
                firstname = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter some text";
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: "Please Enter Your Name",
                labelText: 'Last Name',
              ),
              onChanged: (value) {
                lastname = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter some text";
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: "Please Enter Your Email",
                labelText: 'Email',
              ),
              onChanged: (value) {
                email = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter some text";
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.date_range),
                hintText: "Please Enter Your Birth Year",
                labelText: 'Birth Year',
              ),
              onChanged: (value) {
                birthyear = value; //for int: =int.parse(value)
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter some text";
                }
                return null;
              },
            ),
          SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: (){
                if (_formKey.currentState!.validate()){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Sending data to cloud firestore"),
                    ),
                    );
                  users.add({'First Name': firstname,'Last Name': lastname,'Email': email, 'Birth Year': birthyear}).then((value) => print('User Information Added')).catchError((error) => print('Failed to Update'));
                }
              },
            child: Text("Submit"),
            ),
          ),
        ],
        ),
      );
      }
    }



 // }


/* //from firestore website
var db = FirebaseFirestore.instance;

// create a new user
final user = <String, dynamic> {
  "first name" : "John",
  "last name" : "David",
  "birth year" : 1997
};

// add new document with a generated ID
db.collection("users").add(user).then(DocumentReference doc) =>
    print('DocumentSnapshot added with ID: ${doc.id}'));

// read data
await db.collection("users").get().then((event)) {
  for (var doc in event.docs){
    print("${doc.id} => ${doc.data()}");
  }
}
*/


