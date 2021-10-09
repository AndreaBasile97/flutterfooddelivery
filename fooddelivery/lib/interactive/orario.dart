import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Scaffold(
        body: SafeArea(child: PickerTime()),
      ),
    ));

class PickerTime extends StatefulWidget {
  const PickerTime({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PickerTime();
}

class _PickerTime extends State<PickerTime> {
  String value;

  DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem(value: item, child: Text(item));

  Future<Info> getInfoFromDB() async {
    QuerySnapshot<Map<String, dynamic>> docSnapshot =
        await FirebaseFirestore.instance.collection("impostazioni").get();
    Info info = Info();
    for (int i = 0; i < docSnapshot.docs.length; i++) {
      if (docSnapshot.docs[i].id == "orarioConsegne") {
        var temp = (docSnapshot.docs[i].data());
        info.setInfo(
            stringToTimeOfDay(temp['oraInizio']),
            stringToTimeOfDay(temp['oraFine']),
            temp['discretizzazione'],
            temp['ordiniPerStep']);
      }
    }
    return info;
  }

  TimeOfDay stringToTimeOfDay(String str) {
    List<String> list = str.split(":");
    return TimeOfDay(hour: int.parse(list[0]), minute: int.parse(list[1]));
  }

  List<String> createList(Info info) {
    int hour = info.inizio.hour;
    int minute = info.inizio.minute;
    List<String> list = [];
    int x = info.step % 60;
    int y = (info.step / 60).floor();
    print(x.toString() + "-" + y.toString());
    while (info.fine.hour - hour > 0 || info.fine.minute - minute > 0) {
      list.add(hour.toString() + ":" + minute.toString());
      print(hour.toString() + " " + minute.toString());
      hour = hour + y;
      minute = minute + x;
      if (minute >= 60) {
        hour = (minute / 60).floor() + hour;
        minute = minute % 60;
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getInfoFromDB(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Info info = snapshot.data as Info;
            return DropdownButton<String>(
                items: createList(info).map(buildMenuItem).toList(),
                onChanged: (value) {
                  setState(() {
                    this.value = value;
                  });
                },
                value: value,
                icon: Icon(Icons.access_alarm));
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

class Info {
  TimeOfDay inizio;
  TimeOfDay fine;
  int step;
  int numPerStep;

  void setInfo(inizio, fine, step, numPerStep) {
    this.fine = fine;
    this.inizio = inizio;
    this.step = step;
    this.numPerStep = numPerStep;
  }
}
