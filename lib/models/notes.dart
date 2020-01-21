
class Note{
  int _id;
  String _title;
  String _contents;
  int _priority;
  String _date;

  Note(this._title, this._date, this._priority, [this._contents]);
  Note.withID(this._id, this._title, this._date, this._priority, [this._contents]);

  int get id => _id;
  String get contents => _contents;
  String get title => _title;
  String get date => _date;
  int get priority => _priority;

  //setters
  set title(String title){
    if(title.length <= 255 && title.isNotEmpty){
      this._title = title;
    }
  }

  set content(String contents){
    if(title.length <= 255 && title.isNotEmpty){
      this._contents = contents;
    }
  }

  set date(String date){
    if(title.length <= 255 && title.isNotEmpty){
      this._date = date;
    }
  }

  set priority(int priority){
    if(priority>=1 && priority<= 2){
      this._priority = priority;
    }
  }

  //convert note object to map
  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    if(id != null){
      map['id'] = _id;
    }
    map['title'] = _title;
    map['contents'] = _contents;
    map['date'] = _date;
    map['priority'] = _priority;

    return map;
  }

  //convert a map object to a note object
  Note.fromMapObject(Map<String, dynamic> map){
    this._id = map['id'];
    this._title = map['title'];
    this._contents = map['contents'];
    this._date = map['date'];
    this._priority = map['priority'];
  }
}