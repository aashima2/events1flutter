import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

//import 'myEvents.dart';
import 'Edit_Events.dart';
import 'New_ Events.dart';
import 'main.dart';
import 'Auth.dart';
import 'Events_details.dart';

class myEvents extends StatefulWidget {
  myEvents({this.user, this.googleSignIn});

  final FirebaseUser user;
  final GoogleSignIn googleSignIn;

  @override
  _myEventsState createState() => _myEventsState();
}

class _myEventsState extends State<myEvents>
    with SingleTickerProviderStateMixin {
  String name;
  String image;
  String uid;
  Auth service = new Auth();

  void _signout() async {
    AlertDialog alertDialog = new AlertDialog(
      content: Container(
        height: 250.0,
        child: Column(
          children: <Widget>[
            ClipOval(
              child: Image.network(image),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Sign out ??",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    service.signOut();
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => MyHomePage()));
                  },
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.check),
                      Padding(padding: EdgeInsets.all(5.0)),
                      Text('Yes',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.close),
                      Padding(padding: EdgeInsets.all(5.0)),
                      Text(
                        'Cancel',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
    showDialog(context: context, child: alertDialog);
  }

  @override
  void initState() {
    service.currentUser().then((uid) {
      setState(() {
        this.uid = uid;
        DocumentReference documentReference =
            Firestore.instance.collection('users').document(uid);
        documentReference.get().then((datasnapshot) {
          setState(() {
            name = datasnapshot.data['displayName'];
            image = datasnapshot.data['photoURL'];
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 65.0,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg1.jpg'), fit: BoxFit.cover),
            color: Colors.purple,
            boxShadow: [BoxShadow(color: Colors.black, blurRadius: 8.0)]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => myEvents()));
                  },
                  icon: (Icon(
                    Icons.home,
                    size: 30.0,
                    color: Colors.white,
                  )),
                ),
                Text(
                  'Home',
                  style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Column(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => New_Events()));
                  },
                  icon: Icon(
                    Icons.event,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
                Text(
                  'Events',
                  style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 51,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/backimage2.jpg"), fit: BoxFit.cover),
        ),
        child: Center(
          child: image == null
              ? CircularProgressIndicator()
              : Column(
                  children: <Widget>[
                    Container(
                      height: 170.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/bg1.jpg'),
                              fit: BoxFit.cover),
                          color: Colors.purple,
                          boxShadow: [
                            BoxShadow(color: Colors.black, blurRadius: 8.0)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 60.0,
                                  width: 60.0,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(image),
                                          fit: BoxFit.cover)),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Welcome",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          name,
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                IconButton(
                                    icon: Icon(Icons.exit_to_app,
                                        color: Colors.white, size: 30.0),
                                    onPressed: () {
                                      _signout();
                                    })
                              ],
                            ),
                          ),
                          Text(
                            "My Events",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontStyle: FontStyle.italic,
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    StreamBuilder(
                        stream:
                            Firestore.instance.collection('events').snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Center(
                                child: const Text(
                              'Loading...',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ));
                          return Expanded(
                            child: MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: ListView.builder(
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (context, index) => buildListItem(
                                    context, snapshot.data.documents[index]),
                              ),
                            ),
                          );
                        }),
                  ],
                ),
        ),
      ),
    );
  }

  buildListItem(BuildContext context, DocumentSnapshot document) {
    return Dismissible(
      key: Key(document.documentID),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        final snackBar = SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.black,
            content: Text(
              'THE EVENT HAS BEEN DELETED!!..',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0),
            ));
        Scaffold.of(context).showSnackBar(snackBar);
        Firestore.instance
            .collection('events')
            .document(document.documentID)
            .delete()
            .whenComplete(() {
          Firestore.instance
              .collection('Activity')
              .where("documentreference", isEqualTo: document.documentID)
              .snapshots()
              .listen((data) =>
                  data.documents.forEach((doc) => doc.reference.delete()));
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: GestureDetector(
          onTap: () {
            print('ab' + document.documentID);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => EventDetails(
                      EventTitle: document['eventtitle'],
                      StartDate: document['startdate'],
                      EndDate: document['enddate'],
                      EventTime: document['time'],
                      Venue: document['venue'],
                      Description: document['description'],
                      Tasktype: document['tasktype'],
                      image: document['taskimage'],
                      dooumentid: document.documentID,
                    )));
          },
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                child: ListTile(
                  trailing: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 50.0,
                      ),
                      onPressed: () {
                        print('document' + document.documentID);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => Edit_Events(
                                  EventTitle: document['eventtitle'],
                                  StartDate: document['startdate'],
                                  EndDate: document['enddate'],
                                  EventTime: document['time'],
                                  Venue: document['venue'],
                                  Description: document['description'],
                                  Tasktype: document['tasktype'],
                                  dooumentid: document.documentID,
                                )));
                      }),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          document['eventtitle'],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 35.0,
                              letterSpacing: 2.0,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          document['startdate'],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontStyle: FontStyle.italic,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            height: 190.0,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(document['taskimage']),
                    fit: BoxFit.cover),
                color: Colors.purple,
                boxShadow: [BoxShadow(color: Colors.black, blurRadius: 8.0)]),
          ),
        ),
      ),
    );
  }
}
