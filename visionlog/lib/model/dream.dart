class Dream {
  Dream({this.datetime, this.title, this.message, this.moodFeel, this.lucid, this.nightmare, this.recurring, this.continuous});

  int id;
  String datetime;
  String title;
  String message;
  String moodFeel;
  String lucid;
  String nightmare;
  String recurring;
  String continuous;

  Dream.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.datetime = map['datetime'];
    this.title = map['title'];
    this.message = map['message'];
    this.moodFeel = map['moodFeel'];
    this.lucid = map['lucid'];
    this.nightmare = map['nightmare'];
    this.recurring = map['recurring'];
    this.continuous = map['continuous'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'datetime': this.datetime,
      'title': this.title,
      'message': this.message,
      'moodFeel': this.moodFeel,
      'lucid': this.lucid,
      'nightmare': this.nightmare,
      'recurring': this.recurring,
      'continuous': this.continuous,
    };
  }

  String toString() {
    return '\n\tDream{id: $id, datetime: $datetime, title: $title, '
        'message: $message, moodFeel: $moodFeel, '
        'lucid: $lucid, nightmare: $nightmare, '
        'recurring: $recurring, continuous: $continuous}';
  }
}
