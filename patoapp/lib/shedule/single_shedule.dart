import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:patoapp/animations/error.dart';
import 'package:patoapp/animations/please_wait.dart';
import 'package:patoapp/animations/time_out.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/models/shedules.dart';
import 'package:patoapp/backend/sync/sync_shedule.dart';
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
  refreshDataDB() async {
    SyncShedule syncShedule = SyncShedule();
    await syncShedule.fetchData();
  }

  @override
  void initState() {
    eventDay = DateTime.parse(widget.shedule.dateEvent);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          "${DateFormat('MMMM').format(eventDay)} ${DateFormat('yyy').format(eventDay)}",
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
              color: Theme.of(context).appBarTheme.backgroundColor,
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
                        Container(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                                      Icons.repeat,
                                      color:
                                          sheduleColors[widget.shedule.color],
                                      size: 18,
                                    ),
                                    Text(
                                      " Repeat: ",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            sheduleColors[widget.shedule.color],
                                      ),
                                    ),
                                    Text(
                                      widget.shedule.repeat,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            sheduleColors[widget.shedule.color],
                                      ),
                                    ),
                                  ],
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
                                      Icons.alarm_on,
                                      color:
                                          sheduleColors[widget.shedule.color],
                                      size: 18,
                                    ),
                                    Text(
                                      " Remind: ",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            sheduleColors[widget.shedule.color],
                                      ),
                                    ),
                                    Text(
                                      "${widget.shedule.remind} minutes early",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color:
                                            sheduleColors[widget.shedule.color],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
                        backgroundColor:
                            MaterialStateProperty.all(patowaveErrorRed),
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
                        _deletingShedule(widget.shedule);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.delete,
                      ),
                    ),
                  ),
                  // Container(width: 10),
                  // Expanded(
                  //   child: ElevatedButton(
                  //     style: ButtonStyle(
                  //       // MaterialStateProperty<Color?>? backgroundColor,
                  //       minimumSize: MaterialStateProperty.all(
                  //         const Size(45, 45),
                  //       ),
                  //       shape: MaterialStateProperty.all(
                  //         const RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.all(
                  //             Radius.circular(30),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     onPressed: () {
                  //       _sheduleCompleted(context);
                  //     },
                  //     child: const Text(
                  //       "Completed",
                  //     ),
                  //   ),
                  // ),
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

  _deletingShedule(SheduleModel data) async {
    showPleaseWait(
      context: context,
      builder: (context) => const ModalFit(),
    );
    String accessToken = await storage.read(key: 'access') ?? "";
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}api/deleting-shedule/'),
        headers: getAuthHeaders(accessToken),
        body: jsonEncode(<String, dynamic>{
          'id': data.id,
        }),
      );

      if (response.statusCode == 201) {
        await refreshDataDB();
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        setState(() {
          widget.fetchShedule();
        });
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        showErrorMessage(
          context: context,
          builder: (context) => const ModalFitError(),
        );
        // throw Exception('Failed to updated customer.');
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      showTimeOutMessage(
        context: context,
        builder: (context) => const ModalFitTimeOut(),
      );
    }
  }
}
