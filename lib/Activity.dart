import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Events_details.dart';

class Activity extends StatefulWidget {
  String activity,
      dooumentid,
      EventTitle,
      StartDate,
      EndDate,
      EventTime,
      Venue,
      Description,
      Tasktype,
      activitytime,
      image;

  Activity({
    this.Tasktype,
    this.Venue,
    this.EventTime,
    this.EventTitle,
    this.StartDate,
    this.Description,
    this.EndDate,
    this.image,
    this.activity,
    this.activitytime,
    this.dooumentid,
  });

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  String acname;

  String _evtime = '';
  TimeOfDay _time = new TimeOfDay.now();

  TextEditingController _textFieldController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<Null> _selecttime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        _evtime = "${picked.hour}:${picked.minute}";
      });
    }
  }

  adddata() {
    CollectionReference documentReference =
        Firestore.instance.collection("Activity");
    documentReference.add({
      "activity": acname,
      "activitytime": _evtime,
      "documentreference": widget.dooumentid
    });
  }

  @override
  void initState() {
    _evtime = "${_time.hour}:${_time.minute}";
  }

  @override
  Widget build(BuildContext context) {
    print('doc1' + widget.dooumentid);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(' Activity',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          children: <Widget>[
            Form(
                key: _formKey,
                child: TextFormField(
                    onSaved: (String activity1) {
                      acname = activity1;
                      print("$acname");
                    },
                    controller: _textFieldController,
                    decoration: InputDecoration(
                      hintText: 'Enter the Activity',
                      labelText: 'Activity',
                    ),
                    validator: (String value) {
                      if (value.isEmpty ||
                          RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$')
                              .hasMatch(value)) {
                        return 'Please fill valid Activity';
                      }
                    })),
            SizedBox(
              height: 20.0,
            ),
            ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Time :",
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    _evtime,
                    style: TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
              trailing: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () {
                    _selecttime(context);
                  }),
            ),
            SizedBox(
              height: 80.0,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
                Widget>[
              InkWell(
                child: RaisedButton(
                    color: Colors.deepOrange,
                    child: Text(
                      'Save',
                      style: TextStyle(
                          fontStyle: FontStyle.italic, color: Colors.white),
                    ),
                    onPressed: () {

                      if (!_formKey.currentState.validate()) {
                        return;
                      }
                      _formKey.currentState.save();
                      print('documentref' + widget.dooumentid);
                      adddata();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => EventDetails(
                            EndDate: widget.EndDate,
                            Description: widget.Description,
                            StartDate: widget.StartDate,
                            EventTitle: widget.EventTitle,
                            EventTime: widget.EventTime,
                            Venue: widget.Venue,
                            Tasktype: widget.Tasktype,
                            activitytime: widget.activitytime,
                            image: widget.image,
                            activity: widget.activity,
                            dooumentid: widget.dooumentid,
                          )));
                    }),
              ),
              InkWell(
                child: RaisedButton(
                    color: Colors.deepOrange,
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          fontStyle: FontStyle.italic, color: Colors.white),
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text(
                        'YOU PRESS CANCEL..!!',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )));
                    }),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
