import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'form_confirmation.dart';
import '../widgets/appbar_header.dart';
import '../services/geo_service.dart';

class CreateScreen extends StatefulWidget {
  static final routeName = '/create-screen';
  createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _formKey = GlobalKey<FormState>();
  EventProposal rawFormData = EventProposal();
  LocationResponse geoLoc;
  bool errorValidLoc = false;
  bool checkingFormData = false;
  //final focus = FocusNode();

  Future<void> logValidator(String location) async {
    GeoService geoApi = GeoService();
    setState(() {
      checkingFormData = true;
    });
    geoLoc = await geoApi.fetchLocation(location);
    setState(() {
      checkingFormData = false;
    });
    if (geoLoc == null) {
      setState(() {
        errorValidLoc = true;
      });
    } else {
      setState(() {
        errorValidLoc = false;
      });
    }
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        FocusScope.of(context).unfocus();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: appbarHeader('Add Event', Colors.black),
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white,
                      Colors.tealAccent,
                      Colors.white,
                      Colors.pink[100],
                      Colors.white,
                    ]),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    //color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 10,
                    blurRadius: 8,
                    offset: Offset(1, 3),
                  ),
                ],
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 40),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 5),
                      TextFormField(
                          //textInputAction: TextInputAction.next,
                          style: TextStyle(
                              fontSize: 18, fontStyle: FontStyle.italic),
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.greenAccent, width: 2.0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.greenAccent, width: 2.0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.pinkAccent, width: 1.0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some name';
                            }
                            if (value.length < 4) {
                              return 'Event name must have at least 4 chars';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            rawFormData.name = value;
                          }
                          // onFieldSubmitted: (_) {
                          //   //FocusScope.of(context).requestFocus(focus);
                          // },
                          ),
                      SizedBox(height: 15),
                      TextFormField(
                        //focusNode: focus,
                        decoration: InputDecoration(
                          labelText: 'Location',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.greenAccent, width: 2.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.greenAccent, width: 2.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.pinkAccent, width: 1.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 18),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter location';
                          }
                          if (value.length < 5) {
                            return 'Location name must have at least 5 chars';
                          }
                          if (errorValidLoc) {
                            return 'Location not found. Please be more precise.';
                          }
                          return null;
                        },
                        onChanged: (rawVal) {
                          rawFormData.location = rawVal;
                        },
                        onSaved: (value) {
                          rawFormData.location = value;
                        },
                      ),
                      SizedBox(height: 15),
                      DateTimeField(
                        onSaved: (value) {
                          rawFormData.date = value;
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please enter date';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Date',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.greenAccent, width: 2.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.greenAccent, width: 2.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.pinkAccent, width: 1.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 18),
                        format: DateFormat('yyyy-MM-dd'),
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                            context: context,
                            firstDate: DateTime(2017),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2030),
                          );
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 18),
                        decoration: InputDecoration(
                          labelText: 'Description',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.greenAccent, width: 2.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.greenAccent, width: 2.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.pinkAccent, width: 1.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onSaved: (value) {
                          rawFormData.description = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter description';
                          }
                          if (value.length < 20) {
                            return 'Event description must have at least 20 chars';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.url,
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 18),
                        decoration: InputDecoration(
                          labelText: 'URL Flyer',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.greenAccent, width: 2.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.greenAccent, width: 2.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.pinkAccent, width: 1.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onSaved: (value) {
                          rawFormData.imageUrl = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter URL';
                          }
                          if (value.length < 8) {
                            return 'URL must have at least 8 chars';
                          }
                          if (!value.startsWith('http://') &&
                              !value.startsWith('https://')) {
                            return 'Please enter a valid URL.';
                          }
                          if (!value.endsWith('.png') &&
                              !value.endsWith('.jpg') &&
                              !value.endsWith('.jpeg')) {
                            return 'Please enter a valid URL.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: RaisedButton(
                          padding: EdgeInsets.all(18),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(
                                  color: Colors.pink[300], width: 0.5)),
                          onPressed: () async {
                            await logValidator(rawFormData.location);
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();

                              Navigator.of(context).pushNamed(
                                  FormConfirmation.routeName,
                                  arguments: {
                                    'rawFormData': rawFormData,
                                    'geoInfo': geoLoc
                                  });
                            }
                          },
                          color: Colors.tealAccent,
                          textColor: Colors.white,
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 3.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ],
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                fontFamily: 'WILD'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            checkingFormData
                ? Dialog(
                    insetPadding: EdgeInsets.only(
                        left: 90, right: 90, top: 250, bottom: 250),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text('Checking event data...',
                            style: TextStyle(color: Colors.tealAccent)),
                      ],
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
