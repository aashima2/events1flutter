import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'Activity.dart';

class EventDetails extends StatefulWidget {
  TextEditingController _textFieldController = TextEditingController();
  String EventTitle,
      StartDate,
      EndDate,
      EventTime,
      Venue,
      Description,
      Tasktype,
      dooumentid,
      activity,
      activitytime,
      image;

  EventDetails(
      {this.EventTitle,
      this.StartDate,
      this.EndDate,
      this.EventTime,
      this.Venue,
      this.Description,
      this.Tasktype,
      this.dooumentid,
      this.image,
      this.activity,
      this.activitytime});

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

String eventtitle, startdate, enddate, eventtime, venue, description, tasktype;
String image;

class _EventDetailsState extends State<EventDetails> {
  String documentid;
  TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    print('doc' + widget.dooumentid);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(' Event Details',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: 200,
//                height: MediaQuery.of(context).size.height - 500,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(widget.image), fit: BoxFit.cover),
                    color: Colors.purple,
                    boxShadow: [
                      BoxShadow(color: Colors.black, blurRadius: 8.0)
                    ]),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                child: Text(
                  widget.EventTitle,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Divider(
                height: 20.0,
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Details : ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Date :' + ' ' + widget.StartDate,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    Text(
                      'Time :' + ' ' + widget.EventTime,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 20.0,
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Venue : ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.Venue,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 20.0,
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Description :',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 20.0),
                child: Container(
                  alignment: AlignmentDirectional.topStart,
                  height: 100.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.blueAccent,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.Description,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ),
              Divider(
                height: 20.0,
              ),
              Container(
                child: ListTile(
                  trailing: RawMaterialButton(
                    onPressed: () {},
                    child: IconButton(
                        iconSize: 30.0,
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          print('documentid :' + widget.dooumentid);
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (BuildContext context) => Activity(
                                        activity: widget.activity,
                                        image: widget.image,
                                        activitytime: widget.activitytime,
                                        Tasktype: widget.Tasktype,
                                        Venue: widget.Venue,
                                        EventTime: widget.EventTime,
                                        EventTitle: widget.EventTitle,
                                        StartDate: widget.StartDate,
                                        Description: widget.Description,
                                        EndDate: widget.EndDate,
                                        dooumentid: widget.dooumentid,
                                      )));
                        }),
                    shape: new CircleBorder(),
                    elevation: 2.0,
                    fillColor: Colors.deepOrange,
                    padding: const EdgeInsets.all(3.0),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(
                          'Activity : ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 10.0,
              ),
              Container(
                height: 100.0,
                child: StreamBuilder(
                    stream: Firestore.instance
                        .collection('Activity')
                        .where("documentreference",
                            isEqualTo: widget.dooumentid)
                        .snapshots(),
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
                      return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) => buildListItem(
                            context, snapshot.data.documents[index]),
                      );
                    }),
              ),
            ],
          ),
        ],
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
                'THE ACTIVITY HAS BEEN DELETED!!..',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0),
              ));
          Scaffold.of(context).showSnackBar(snackBar);
          Firestore.instance
              .collection('Activity')
              .document(document.documentID)
              .delete();
        },
        child: Container(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(document['activity'] +
                    '   ' 'Time' +
                    ':' +
                    document['activitytime']),
              )
            ],
          ),
        ));
  }
}
