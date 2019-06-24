import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'myEvents.dart';
import 'Auth.dart';

class New_Events extends StatefulWidget {
  New_Events({this.user, this.googleSignIn});

  final FirebaseUser user;
  final GoogleSignIn googleSignIn;

  @override
  _New_EventsState createState() => _New_EventsState();
}

class _New_EventsState extends State<New_Events> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Auth service = new Auth();
  String uid ='';

  DateTime _date = new DateTime.now();
  DateTime _date1 = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();
  String _dateformat = '';

  String _dateformat1 = '';
  String _evtime = '';
  String image;


  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1996),
        lastDate: DateTime(2024));
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
        _dateformat = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<Null> _selectDate1(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date1,
        firstDate: DateTime(1996),
        lastDate: DateTime(2024));

    if (picked != null && picked != _date1) {
      setState(() {
        _date1 = picked;
        _dateformat1 = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

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



  String EventTitle, StartDate, EndDate, EventTime, Venue, Description;

  getEventTitle(eventTitle) {
    this.EventTitle = eventTitle;
  }

  getStartDate(startdate) {
    this.StartDate = startdate;
  }

  getEndDate(enddate) {
    this.EndDate = enddate;
  }

  getTime(eventtime) {
    this.EventTime = eventtime;
  }

  getVenue(venue) {
    this.Venue = venue;
  }

  getDescription(description) {
    this.Description = description;
  }

  addData() {
    CollectionReference reference = Firestore.instance.collection("events");
    reference.add({
      "eventtitle": EventTitle,
      "startdate": _dateformat,
      "enddate": _dateformat1,
      "time": _evtime,
      "venue": Venue,
      "description": Description,
      "tasktype": Eventval,
      "taskimage": image,
      "uid": uid,
    });
  }

  int _myEventsType = 0;
  String Eventval;

  void _handleEventType(int value) {
    setState(() {
      _myEventsType = value;

      switch (_myEventsType) {
        case 1:
          Eventval = 'Occasion';
          image = 'assets/birthday.jpg';
          break;
        case 2:
          Eventval = 'Festival';
          image = 'assets/festival1.jpg';
          break;
        case 3:
          Eventval = 'Others';
          image = 'assets/Allevents.jpg';
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _dateformat = "${_date.day}/${_date.month}/${_date.year}";
    _dateformat1 = "${_date1.day}/${_date1.month}/${_date1.year}";
    _evtime = "${_time.hour}:${_time.minute}";
    _handleEventType(1);
    service.currentUser().then((uid) {
      setState(() {
        this.uid = uid;
       print('uid'+ uid);
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
//      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('New Events',
            style: TextStyle(
              fontSize: 20.0,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height  ,
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: TextFormField(
                        onSaved: (String evtitle) {
                          getEventTitle(evtitle);
                        },
                        validator: (String value) {
                          if (value.isEmpty ||
                              RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$')
                                  .hasMatch(value)) {
                            return 'Please fill valid title';
                          }

                        },
                        decoration: InputDecoration(
                          labelText: "Events Title : ",
                        ),
                      ),
                    ),
                    // start date
                    SizedBox(
                      height: 10.0,
                    ),

                    ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Start Date :",
                            style: TextStyle(fontSize: 14.0),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 1.0),
                            child: Text(
                              _dateformat,
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () {
                            _selectDate(context);
                          }),
                    ),

                    // End date

                    SizedBox(
                      height: 10.0,
                    ),

                    ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "End Date :",
                            style: TextStyle(fontSize: 14.0),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 1.0),
                            child: Text(
                              _dateformat1,
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () {
                            _selectDate1(context);
                          }),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    // Time
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
                          Padding(
                            padding: const EdgeInsets.only(left: 1.0),
                            child: Text(
                              _evtime,
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                          icon: Icon(Icons.timer),
                          onPressed: () {
                            _selecttime(context);
                          }),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: TextFormField(
                        onSaved: (String evenue) {
                          getVenue(evenue);
                        },
                        validator: (String value) {
                          if (value.isEmpty ||
                              RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$')
                                  .hasMatch(value)) {
                            return 'Please fill valid Venue';
                          }

//                          if (value.isEmpty) {
//                            return 'Field cannot be empty';
//                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Venue : ",
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 2,
                        onSaved: (String edescription) {
                          getDescription(edescription);
                        },
                        validator: (String value) {
                          if (value.isEmpty ||
                              RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$')
                                  .hasMatch(value)) {
                            return 'Please fill valid Description';
                          }
//                          if (value.isEmpty) {
//                            return 'Field cannot be empty';
//                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Description : ",
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),

                    Center(
                        child: Text(
                      'Select Events Type',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Radio(
                              value: 1,
                              groupValue: _myEventsType,
                              onChanged: _handleEventType,
                              activeColor: Color(0xff4158ba),
                            ),
                            Text(
                              "Occasion",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Radio(
                              value: 2,
                              groupValue: _myEventsType,
                              onChanged: _handleEventType,
                              activeColor: Color(0xff4158ba),
                            ),
                            Text(
                              "Festival",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Radio(
                              value: 3,
                              groupValue: _myEventsType,
                              onChanged: _handleEventType,
                              activeColor: Color(0xff4158ba),
                            ),
                            Text(
                              "Others",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 18.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton(
                              color: Colors.deepOrange,
                              onPressed: () {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: Text(
                                      'YOU PRESSED CANCEL',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                    )));

                              },

//

                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              ),
                            ),
                            RaisedButton(
                              color: Colors.deepOrange,
                              onPressed: () {
                                if (!_formKey.currentState.validate()) {
                                  return;
                                }
                                _formKey.currentState.save();

                                if (_date1.isBefore(_date)) {
                                  _scaffoldKey.currentState.showSnackBar(SnackBar(content:  Text('Error !! Enter End date correctly',style:
                                  TextStyle(fontWeight: FontWeight.bold),)));

                                } else {
                                  AlertDialog alertDialog = new AlertDialog(
                                    actions: <Widget>[
                                      InkWell(
                                        child: RaisedButton(
                                          color: Colors.deepOrange,
                                          onPressed: () {
                                            addData();
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.of(context).pushReplacement(
                                                MaterialPageRoute(
                                                    builder:
                                                        (BuildContext context) =>
                                                            myEvents()));
                                          },
                                          child: Text(
                                            "Ok",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                    content: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        " Events inserted Successfully...",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16.0),
                                      ),
                                    ),
                                  );

                                  showDialog(
                                      context: context, child: alertDialog);
                                  //  function of creation of data has to be created here
                                }
                              },
                              child: const Text(
                                "Submit",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
