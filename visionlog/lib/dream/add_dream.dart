import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/dream.dart';
import '../model/dream_model.dart';

class AddDream extends StatefulWidget {
  AddDream({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AddDreamState createState() => _AddDreamState();
}

class _AddDreamState extends State<AddDream> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  String _date = '';
  String _time = '';
  String _title = '';
  String _message = '';
  String _moodFeel = 'average';
  String _lucid = 'false';
  String _nightmare = 'false';
  String _recurring = 'false';
  String _continuous = 'false';

  bool isLucidSwitched = false;
  bool isNightmareSwitched = false;
  bool isRecurringSwitched = false;
  bool isContinuousSwitched = false;

  final _model = DreamModel();
  Dream _dream;
  var _lastInsertedId = 0;

  //  Initializes which ToggleButton is selected in beginning
  List<bool> isSelected = [false, false, true, false, false];

  TextEditingController _titleTextEditingController = TextEditingController();
  TextEditingController _messageTextEditingController = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        _dream = ModalRoute.of(context).settings.arguments;
        print(_dream);
        if (_dream != null) {
          print(_dream);
          List<String> _datetime = (_dream.datetime).split(" ");
          _date = _datetime[0];
          _time = _datetime[1] + " " + _datetime[2];
          _moodFeel = _dream.moodFeel;
          _lucid = _dream.lucid;
          _nightmare = _dream.nightmare;
          _recurring = _dream.recurring;
          _continuous = _dream.continuous;
          _title = _dream.title;
          _message = _dream.message;

          if (_lucid == 'true') {
            isLucidSwitched = true;
            print("lucid is true");
          }
          if (_nightmare == 'true') {
            isNightmareSwitched = true;
            print("nightmare is true");
          }
          if (_recurring == 'true') isRecurringSwitched = true;
          if (_continuous == 'true') isContinuousSwitched = true;

          if (_moodFeel == 'terrible')
            isSelected = [true, false, false, false, false];
          if (_moodFeel == 'bad')
            isSelected = [false, true, false, false, false];
          if (_moodFeel == 'average')
            isSelected = [false, false, true, false, false];
          if (_moodFeel == 'okay')
            isSelected = [false, false, false, true, false];
          if (_moodFeel == 'fantastic')
            isSelected = [false, false, false, false, true];

          _titleTextEditingController.text = _title;
          _messageTextEditingController.text = _message;
        } else {
          _time = selectedTime.format(context);
          _date = formatter.format(selectedDate);
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              // Feel Colour
              Container(
                height: 6.0,
                color: Colors.deepPurple,
              ),
              // Date & Time Pickers
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlineButton(
                      borderSide: BorderSide(color: const Color(0xff2C2B30)),
                      visualDensity: VisualDensity.compact,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(4.0)),
                      onPressed: () => _selectDate(context),
                      textColor: Colors.white60,
                      child: Text(
                        _date,
                        textScaleFactor: 1.25,
                      ),
                    ),
                    Divider(
                      indent: 8.0,
                    ),
                    OutlineButton(
                      borderSide: BorderSide(color: const Color(0xff2C2B30)),
                      visualDensity: VisualDensity.compact,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(4.0)),
                      onPressed: () => _selectTime(context),
                      textColor: Colors.white60,
                      child: Text(
                        _time,
                        textScaleFactor: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
              // Feel
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Feel:',
                      textScaleFactor: 1.75,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(
                      indent: 8.0,
                    ),
                    ToggleButtons(
                      children: <Widget>[
                        Icon(Icons.sentiment_very_dissatisfied, size: 36.0),
                        Icon(Icons.sentiment_dissatisfied, size: 36.0),
                        Icon(Icons.sentiment_neutral, size: 36.0),
                        Icon(Icons.sentiment_satisfied, size: 36.0),
                        Icon(Icons.sentiment_very_satisfied, size: 36.0),
                      ],
                      onPressed: (int index) {
                        setState(() {
                          //  Prevents more than one button being selected
                          for (int buttonIndex = 0;
                              buttonIndex < isSelected.length;
                              buttonIndex++) {
                            if (buttonIndex == index) {
                              isSelected[buttonIndex] = true;
                            } else {
                              isSelected[buttonIndex] = false;
                            }
                          }
                        });

                        switch (index) {
                          case 0:
                            {
                              _moodFeel = 'terrible';
                            }
                            break;
                          case 1:
                            {
                              _moodFeel = 'bad';
                            }
                            break;
                          case 2:
                            {
                              _moodFeel = 'average';
                            }
                            break;
                          case 3:
                            {
                              _moodFeel = 'okay';
                            }
                            break;
                          case 4:
                            {
                              _moodFeel = 'fantastic';
                            }
                            break;
                          default:
                            {
                              _moodFeel = 'average';
                            }
                            break;
                        }
                      },
                      renderBorder: false,
                      borderColor: Colors.transparent,
                      fillColor: Colors.transparent,
                      color: Colors.white10,
                      isSelected: isSelected,
                    ),
                  ],
                ),
              ),
              // Switches
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  height: 24.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Lucid',
                        textScaleFactor: 1.25,
                      ),
                      Switch(
                        value: isLucidSwitched,
                        onChanged: (value) {
                          setState(() {
                            isLucidSwitched = value;
                            _lucid = value.toString();
                          });
                        },
                        inactiveTrackColor: Colors.white38,
                        activeTrackColor: Colors.deepPurpleAccent,
                        activeColor: Colors.deepPurple,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  height: 24.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nightmare',
                        textScaleFactor: 1.25,
                      ),
                      Switch(
                        value: isNightmareSwitched,
                        onChanged: (value) {
                          setState(() {
                            isNightmareSwitched = value;
                            _nightmare = value.toString();
                            isSelected[0] = true;
                            isSelected[1] = false;
                            isSelected[2] = false;
                            isSelected[3] = false;
                            isSelected[4] = false;
                            _moodFeel = 'terrible';
                            print(_moodFeel);
                          });
                        },
                        inactiveTrackColor: Colors.white38,
                        activeTrackColor: Colors.deepPurpleAccent,
                        activeColor: Colors.deepPurple,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  height: 24.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recurring',
                        textScaleFactor: 1.25,
                      ),
                      Switch(
                        value: isRecurringSwitched,
                        onChanged: (value) {
                          setState(() {
                            isRecurringSwitched = value;
                            _recurring = value.toString();
                          });
                        },
                        inactiveTrackColor: Colors.white38,
                        activeTrackColor: Colors.deepPurpleAccent,
                        activeColor: Colors.deepPurple,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  height: 24.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Continuous',
                        textScaleFactor: 1.25,
                      ),
                      Switch(
                        value: isContinuousSwitched,
                        onChanged: (value) {
                          setState(() {
                            isContinuousSwitched = value;
                            _continuous = value.toString();
                          });
                        },
                        inactiveTrackColor: Colors.white38,
                        activeTrackColor: Colors.deepPurpleAccent,
                        activeColor: Colors.deepPurple,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 1.5,
                  color: const Color(0xff0B0A0D),
                ),
              ),
              // Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: _titleTextEditingController,
                  onChanged: (text) {
                    _title = text;
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    isDense: true,
                    hintText: 'Title...',
                    hintStyle: TextStyle(color: Colors.white60),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: const Color(0xff2C2B30)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: const Color(0xff2C2B30)),
                    ),
                  ),
                ),
              ),
              // Message
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: TextField(
                  controller: _messageTextEditingController,
                  onChanged: (text) {
                    _message = text;
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    isDense: true,
                    hintText: 'Tap here to write dream...',
                    hintStyle: TextStyle(color: Colors.white60),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: const Color(0xff2C2B30)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: const Color(0xff2C2B30)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAlertDialog(context);
          },
          tooltip: 'Save',
          child: Icon(Icons.save),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    //  Creates DateTimePickerDialog
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _date = formatter.format(selectedDate);
      });
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
        _time = selectedTime.format(context);
      });
  }

  Future<void> _addDream(Dream dream) async {
    _lastInsertedId = await _model.insertDream(dream);
    print('Dream inserted: $_lastInsertedId');
  }

  Future<void> _updateDream(Dream dream) async {
    if (_dream.id != null) {
      await _model.updateDream(dream);
      print("Updated Dream at ID: " + _dream.id.toString());
    }
  }

  _showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget confirmButton = FlatButton(
      child: Text("Confirm"),
      onPressed: () {
        Dream newDream = Dream(
          datetime: _date + ' ' + _time,
          title: _title,
          message: _message,
          moodFeel: _moodFeel,
          lucid: _lucid,
          nightmare: _nightmare,
          recurring: _recurring,
          continuous: _continuous,
        );

        if (_dream != null) {
          newDream.id = _dream.id;
          print("updating...");
          print(newDream);
          _updateDream(newDream);

          int count = 0;
          Navigator.popUntil(context, (route) {
            return count++ == 4;
          });
        }
        else {
          _addDream(newDream);
          Navigator.of(context).pop(newDream);
          Navigator.of(context).pop(newDream);
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: const Color(0xFF121219),
      title: Text(
        'Are you sure you want to save?',
        style: TextStyle(color: Colors.white70),
      ),
      actions: [
        cancelButton,
        confirmButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
