import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddDream extends StatefulWidget {
  AddDream({Key? key, this.title}) : super(key: key);
  final String? title;

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
  var _lastInsertedId = 0;

  //  Initializes which ToggleButton is selected in beginning
  List<bool> isSelected = [false, false, true, false, false];

  TextEditingController _titleTextEditingController = TextEditingController();
  TextEditingController _messageTextEditingController = TextEditingController();

  @override
  void initState() {

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
          },
          tooltip: 'Save',
          child: Icon(Icons.save),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    //  Creates DateTimePickerDialog
    final DateTime? picked = await showDatePicker(
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
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
        _time = selectedTime.format(context);
      });
  }
}
