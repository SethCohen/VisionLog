import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'dream.dart';

class EditDream extends StatefulWidget {
  EditDream(this.arguments, {Key? key}) : super(key: key);

  final Dream arguments;

  @override
  _EditDreamState createState() => _EditDreamState();
}

class _EditDreamState extends State<EditDream> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  String _date = DateFormat.yMd().format(DateTime.now());
  String _time = DateFormat.jm().format(DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      TimeOfDay.now().hour,
      TimeOfDay.now().minute));
  String _title = '';
  String _message = '';
  String _feel = 'average';
  bool _lucid = false;
  bool _nightmare = false;
  bool _recurring = false;
  bool _continuous = false;

  bool isLucidSwitched = false;
  bool isNightmareSwitched = false;
  bool isRecurringSwitched = false;
  bool isContinuousSwitched = false;

  //  Initializes which Feel ToggleButton is selected by default.
  List<bool> feelSelected = [false, false, true, false, false];

  TextEditingController _titleTextEditingController = TextEditingController();
  TextEditingController _messageTextEditingController = TextEditingController();


  Map _feelColours = {
    'terrible': Color(0xffff9595),
    'bad': Color(0xffffdd99),
    'average': Color(0xffbeffb0),
    'okay': Color(0xff9ecdff),
    'fantastic': Color(0xffa49eff)
  };

  @override
  void initState() {
    super.initState();
    print(widget.arguments);

    _selectedDate = widget.arguments.datetime;
    _selectedTime = TimeOfDay.fromDateTime(widget.arguments.datetime);

    _date = DateFormat.yMd().format(widget.arguments.datetime);
    _time = DateFormat.jm().format(DateTime(
        widget.arguments.datetime.year,
        widget.arguments.datetime.month,
        widget.arguments.datetime.day,
        widget.arguments.datetime.hour,
        widget.arguments.datetime.minute));
    _title = widget.arguments.title!;
    _message = widget.arguments.message!;
    _feel = widget.arguments.feel;
    _lucid = widget.arguments.isLucid;
    _nightmare = widget.arguments.isNightmare;
    _recurring = widget.arguments.isRecurring;
    _continuous = widget.arguments.isContinuous;

    isLucidSwitched = widget.arguments.isLucid;
    isNightmareSwitched = widget.arguments.isNightmare;
    isRecurringSwitched = widget.arguments.isRecurring;
    isContinuousSwitched = widget.arguments.isContinuous;

    //  Initializes which Feel ToggleButton is selected by default.
    feelSelected = [
      widget.arguments.feel == 'terrible' ? true : false,
      widget.arguments.feel == 'bad' ? true : false,
      widget.arguments.feel == 'average' ? true : false,
      widget.arguments.feel == 'okay' ? true : false,
      widget.arguments.feel == 'fantastic' ? true : false
    ];

    _titleTextEditingController = TextEditingController(text: _title);
    _messageTextEditingController = TextEditingController(text: _message);

  }

  Future<void> editDream(dream) {
    return dream.reference!
        .update({
          'timestamp': DateTime(_selectedDate!.year, _selectedDate!.month,
              _selectedDate!.day, _selectedTime!.hour, _selectedTime!.minute),
          'feel': _feel,
          'title': _title,
          'message': _message,
          'is_lucid': _lucid,
          'is_nightmare': _nightmare,
          'is_recurring': _recurring,
          'is_continuous': _continuous
        })
        .then((value) => print("Dream Edited"))
        .catchError((error) => print("Failed to edit dream: $error"));
  }

  @override
  Widget build(BuildContext context) {
    Dream dream = widget.arguments;

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
                    OutlinedButton(
                      onPressed: () => _selectDate(context),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: const Color(0xff2C2B30)),
                        visualDensity: VisualDensity.compact,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(4.0)),
                        primary: Colors.white60,
                      ),
                      child: Text(
                        _date!,
                        textScaleFactor: 1.25,
                      ),
                    ),
                    Divider(
                      indent: 8.0,
                    ),
                    OutlinedButton(
                      onPressed: () => _selectTime(context),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: const Color(0xff2C2B30)),
                        visualDensity: VisualDensity.compact,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(4.0)),
                        primary: Colors.white60,
                      ),
                      child: Text(
                        _time!,
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
                              buttonIndex < feelSelected!.length;
                              buttonIndex++) {
                            if (buttonIndex == index) {
                              feelSelected![buttonIndex] = true;
                            } else {
                              feelSelected![buttonIndex] = false;
                            }
                          }
                        });

                        switch (index) {
                          case 0:
                            {
                              _feel = 'terrible';
                            }
                            break;
                          case 1:
                            {
                              _feel = 'bad';
                            }
                            break;
                          case 2:
                            {
                              _feel = 'average';
                            }
                            break;
                          case 3:
                            {
                              _feel = 'okay';
                            }
                            break;
                          case 4:
                            {
                              _feel = 'fantastic';
                            }
                            break;
                          default:
                            {
                              _feel = 'average';
                            }
                            break;
                        }
                      },
                      renderBorder: false,
                      borderColor: Colors.transparent,
                      fillColor: Colors.transparent,
                      color: Colors.white10,
                      isSelected: feelSelected!,
                      selectedColor: _feelColours[_feel],
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
                        value: isLucidSwitched!,
                        onChanged: (value) {
                          setState(() {
                            isLucidSwitched = value;
                            _lucid = value;
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
                        value: isNightmareSwitched!,
                        onChanged: (value) {
                          setState(() {
                            isNightmareSwitched = value;
                            _nightmare = value;
                            feelSelected![0] = true;
                            feelSelected![1] = false;
                            feelSelected![2] = false;
                            feelSelected![3] = false;
                            feelSelected![4] = false;
                            _feel = 'terrible';
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
                        value: isRecurringSwitched!,
                        onChanged: (value) {
                          setState(() {
                            isRecurringSwitched = value;
                            _recurring = value;
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
                        value: isContinuousSwitched!,
                        onChanged: (value) {
                          setState(() {
                            isContinuousSwitched = value;
                            _continuous = value;
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
            editDream(dream);
            Navigator.of(context).popUntil((route) => route.isFirst);
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
      initialDate: _selectedDate!,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        _date = DateFormat.yMd().format(_selectedDate!);
      });
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime!,
    );
    if (picked != null && picked != _selectedTime)
      setState(() {
        _selectedTime = picked;

        _time = _selectedTime!.format(context);
      });
  }
}
