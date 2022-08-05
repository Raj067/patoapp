import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:patoapp/backend/models/shedules.dart';
import 'package:patoapp/shedule/sample.dart';
import 'package:patoapp/themes/light_theme.dart';

class SingleShedule extends StatefulWidget {
  final Function fetchShedule;
  final SheduleModel shedule;
  const SingleShedule(
      {Key? key, required this.fetchShedule, required this.shedule})
      : super(key: key);

  @override
  State<SingleShedule> createState() => _SingleSheduleState();
}

class _SingleSheduleState extends State<SingleShedule> {
  DateTime eventDay = DateTime.now();
  @override
  void initState() {
    eventDay = DateTime.parse(widget.shedule.dateEvent);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: patowavePrimary,
        centerTitle: true,
        title: Text(
          DateFormat('MMMM').format(eventDay),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: patowaveWhite,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: patowaveWhite,
          ),
        ),
      ),
      body: Container(
        color: Theme.of(context).cardColor,
        child: Column(
          children: [
            Container(
              color: patowavePrimary,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _singleDay(
                          DateTime(
                            eventDay.year,
                            eventDay.month,
                            eventDay.day - 2,
                          ),
                        ),
                        _singleDay(
                          DateTime(
                            eventDay.year,
                            eventDay.month,
                            eventDay.day - 1,
                          ),
                        ),
                        _singleDayActive(eventDay),
                        _singleDay(
                          DateTime(
                            eventDay.year,
                            eventDay.month,
                            eventDay.day + 1,
                          ),
                        ),
                        _singleDay(
                          DateTime(
                            eventDay.year,
                            eventDay.month,
                            eventDay.day + 2,
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            widget.shedule.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: sheduleColors[widget.shedule.color]
                                .withAlpha(50),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.alarm,
                                  color: sheduleColors[widget.shedule.color],
                                  size: 18,
                                ),
                                Text(
                                  "  From: ${widget.shedule.startTime} To: ${widget.shedule.endTime}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: sheduleColors[widget.shedule.color],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.shedule.description,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    child: const Text('hello'),
                    onPressed: () async {
                      // MyHomePage1
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const MyHomePage1(title: "hello"),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        // MaterialStateProperty<Color?>? backgroundColor,
                        minimumSize: MaterialStateProperty.all(
                          const Size(45, 45),
                        ),
                        shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        _sheduleCompleted(context);
                      },
                      child: const Text(
                        "Shedule Completed",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _singleDay(DateTime day) {
    return Expanded(
      child: SizedBox(
        height: 75,
        child: Card(
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            side: BorderSide(color: patowaveWhite, width: 0.7),
          ),
          color: patowavePrimary.withAlpha(50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat('EEE').format(day),
                style: const TextStyle(fontSize: 12, color: patowaveWhite),
              ),
              const SizedBox(height: 10),
              Text(
                "${day.day}",
                style: const TextStyle(fontSize: 14, color: patowaveWhite),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _singleDayActive(DateTime day) {
    return Expanded(
      child: SizedBox(
        height: 75,
        child: Card(
          // color: Colors.white,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          // color: patowavePrimary.withAlpha(50),
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat('EEE').format(day),
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 10),
                Text(
                  "${day.day}",
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _sheduleCompleted(BuildContext context) async {
    widget.fetchShedule();
    Navigator.pop(context);
  }
}
