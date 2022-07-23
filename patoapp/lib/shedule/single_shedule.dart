import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:patoapp/backend/models/shedules.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:table_calendar/table_calendar.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shedule',
          style: TextStyle(color: Colors.white),
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height > 510
              ? MediaQuery.of(context).size.height
              : 510,
          color: patowavePrimary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 260,
                // color: Colors.blue,
                child: TableCalendar(
                  firstDay: DateTime.utc(2010, 1, 1),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: DateTime.now(),
                  rowHeight: 30.0,
                  // calendarFormat: CalendarFormat.week,
                  // shouldFillViewport: true,
                  // calendarStyle: const CalendarStyle(
                  //   todayDecoration: BoxDecoration(
                  //       color: Colors.yellow, shape: BoxShape.rectangle),
                  //   // cellPadding: EdgeInsets.all(1),
                  // ),
                  headerStyle: const HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                  ),
                  // headerVisible:false,
                ),
              ),
              Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  height: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            widget.shedule.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Divider(),
                        Row(
                          children: [
                            Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: patowavePrimary.withAlpha(50),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Start: ${widget.shedule.startTime}",
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    "assets/svg/line1.svg",
                                    width: 25,
                                    height: 60,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: patowavePrimary.withAlpha(50),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "End: ${widget.shedule.endTime}",
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.shedule.description,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
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
                      ],
                    ),
                  )),
            ],
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
