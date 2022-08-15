import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:patoapp/animations/error.dart';
import 'package:patoapp/animations/please_wait.dart';
import 'package:patoapp/animations/time_out.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/themes/light_theme.dart';

// ignore: depend_on_referenced_packages
import 'package:timezone/timezone.dart' as tz;

class AddSheduleNew extends StatefulWidget {
  final Function fetchShedule;
  const AddSheduleNew({Key? key, required this.fetchShedule}) : super(key: key);

  @override
  State<AddSheduleNew> createState() => _AddSheduleNewState();
}

class _AddSheduleNewState extends State<AddSheduleNew> {
  final addSheduleFormKey = GlobalKey<FormState>();
  TextEditingController myTitle = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController sheduleDate = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  int remindSelected = 0;
  String repeatSelected = 'Once';
  List<int> remind = [0, 5, 10, 15, 30];
  List<String> repeat = ['Once', 'Daily', 'Weekly'];
  int selectedColor = 0;

  FlutterLocalNotificationsPlugin? flutterNotificationPlugin;
  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Hello Everyone"),
        content: Text(payload),
      ),
    );
  }

  @override
  void initState() {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/launcher_icon');

    var initializationSettingsIOS = const IOSInitializationSettings();

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterNotificationPlugin = FlutterLocalNotificationsPlugin();

    flutterNotificationPlugin!.initialize(initializationSettings,
        onSelectNotification: (val) => onSelectNotification);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Shedule',
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
      body: Form(
        key: addSheduleFormKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          children: [
            Container(height: 15),
            TextFormField(
              cursorColor: patowavePrimary,
              controller: myTitle,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Title is required';
                }
                return null;
              },
              decoration: const InputDecoration(
                label: Text(
                  "Title*",
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
              ),
            ),
            Container(height: 15),
            TextFormField(
              cursorColor: patowavePrimary,
              controller: description,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              minLines: 4,
              maxLines: null,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Description is required';
                }
                return null;
              },
              decoration: const InputDecoration(
                label: Text(
                  "Description*",
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
              ),
            ),
            Container(height: 15),
            TextFormField(
              cursorColor: patowavePrimary,
              controller: sheduleDate,
              //editing controller of this TextField
              decoration: const InputDecoration(
                suffixIcon: Icon(
                  Icons.calendar_month,
                  color: patowavePrimary,
                ),
                label: Text(
                  "Date of Event*",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
              readOnly: true,
              //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 5),
                    //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(DateTime.now().year + 5));

                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  setState(() {
                    sheduleDate.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {}
              },
            ),
            Container(height: 15),
            Row(children: [
              Expanded(
                child: TextFormField(
                  cursorColor: patowavePrimary,
                  controller: startTime,
                  //editing controller of this TextField
                  decoration: const InputDecoration(
                    suffixIcon: Icon(
                      Icons.alarm,
                      color: patowavePrimary,
                    ),
                    label: Text(
                      "Start Time",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                  readOnly: true,
                  //set it true, so that user will not able to edit text
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());

                    if (pickedTime != null) {
                      setState(() {
                        startTime.text =
                            "${pickedTime.hour}:${pickedTime.minute}";
                        // .toString(); //set output date to TextField value.
                      });
                    } else {}
                  },
                ),
              ),
              Container(width: 10),
              Expanded(
                child: TextFormField(
                  cursorColor: patowavePrimary,
                  controller: endTime,
                  //editing controller of this TextField
                  decoration: const InputDecoration(
                    suffixIcon: Icon(
                      Icons.alarm,
                      color: patowavePrimary,
                    ),
                    label: Text(
                      "End Time",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                  readOnly: true,
                  //set it true, so that user will not able to edit text
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());

                    if (pickedTime != null) {
                      setState(() {
                        endTime.text =
                            "${pickedTime.hour}:${pickedTime.minute}";
                        // .toString(); //set output date to TextField value.
                      });
                    } else {}
                  },
                ),
              ),
            ]),
            Container(height: 15),
            DropdownButtonFormField2(
              selectedItemHighlightColor: patowavePrimary.withAlpha(50),
              scrollbarAlwaysShow: true,
              dropdownMaxHeight: 200,
              validator: (value) {
                if (value == null || value == '') {
                  return 'This field is required';
                }
                return null;
              },
              decoration: InputDecoration(
                label: const Text(
                  'Repeat',
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              isExpanded: true,
              icon: const Icon(
                Icons.arrow_drop_down,
              ),
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              items: repeat
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                //Do something when changing the item if you want.
                repeatSelected = value.toString();
                setState(() {});
              },
              onSaved: (value) {},
            ),
            Container(height: 15),
            DropdownButtonFormField2(
              selectedItemHighlightColor: patowavePrimary.withAlpha(50),
              scrollbarAlwaysShow: true,
              dropdownMaxHeight: 200,
              validator: (value) {
                if (value == null || value == '') {
                  return 'This field is required';
                }
                return null;
              },
              decoration: InputDecoration(
                label: const Text(
                  'Remind',
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              isExpanded: true,
              icon: const Icon(
                Icons.arrow_drop_down,
              ),
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              items: remind
                  .map((item) => DropdownMenuItem<String>(
                        value: '$item',
                        child: Text(
                          "$item minutes early",
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                //Do something when changing the item if you want.
                remindSelected = int.parse(value.toString());

                setState(() {});
              },
              onSaved: (value) {},
            ),
            Container(height: 15),
            const Text('Color'),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Wrap(
                  children: List<Widget>.generate(
                6,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedColor = index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      backgroundColor: sheduleColors[index],
                      radius: 15,
                      child: index == selectedColor
                          ? const Icon(Icons.done, color: patowaveWhite)
                          : const Text(''),
                    ),
                  ),
                ),
              )),
            ),
            Container(height: 15),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
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
                  // Validate returns true if the form is valid, or false otherwise.
                  if (addSheduleFormKey.currentState!.validate()) {
                    // _reSetAllShedule();
                    _submitShedule(context);
                  }
                },
                child: const Text(
                  "Add Shedule",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future notificationDefaultSound({
    required int id,
    required String title,
    required String description,
  }) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      "$id",
      'Shedule',
      channelDescription: 'Description',
      importance: Importance.max,
      priority: Priority.high,
    );

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    flutterNotificationPlugin?.show(
        id, title, description, platformChannelSpecifics,
        payload: 'Default Sound');
  }

  Future<void> _scheduledNotification({
    required int id,
    required String title,
    required String description,
  }) async {
    DateTime recent = DateTime.parse("${sheduleDate.text} ${startTime.text}");
    // tz.;
    final scheduledDate = tz.TZDateTime(
        tz.getLocation('Africa/Nairobi'),
        recent.year,
        recent.month,
        recent.day,
        recent.hour,
        recent.minute - remindSelected,
        recent.second);
    await flutterNotificationPlugin?.zonedSchedule(
      id,
      title,
      description,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily notification channel id',
          'daily notification channel name',
          channelDescription: 'daily notification description',
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: repeatSelected.toLowerCase() == 'once'
          ? null
          : repeatSelected.toLowerCase() == 'daily'
              ? DateTimeComponents.time
              : DateTimeComponents.dayOfWeekAndTime,
    );
  }

  // Future<void> _deleteNotificationChannel() async {
  //   const String channelId = 'your channel id 2';
  //   await flutterNotificationPlugin
  //       ?.resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.deleteNotificationChannel(channelId);

  //   await showDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) => AlertDialog(
  //       content: const Text('Channel with id $channelId deleted'),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //           child: const Text('OK'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // _reSetAllShedule() async {
  //   List<Map<String, dynamic>> shedules = await DBHelperShedule.query();
  //   for (var e in shedules) {
  //     fromJsonShedule(e);
  //   }
  // }

  _submitShedule(BuildContext context) async {
    showPleaseWait(
      context: context,
      builder: (context) => const ModalFit(),
    );
    String accessToken = await storage.read(key: 'access') ?? "";
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}api/add-shedule/'),
        headers: getAuthHeaders(accessToken),
        body: jsonEncode(<String, dynamic>{
          'title': myTitle.text,
          'description': description.text,
          'dateEvent': sheduleDate.text,
          'startTime': startTime.text,
          'endTime': endTime.text,
          'color': selectedColor,
          'repeat': repeatSelected,
          'remind': remindSelected,
        }),
      );
      if (response.statusCode == 201) {
        // Setting shedule
        // if time is not future, hence pass
        try {
          _scheduledNotification(
              id: jsonDecode(response.body)['id'],
              title: myTitle.text,
              description: description.text);
        } catch (e) {
          //
        }

        // end of making shedule
        await widget.fetchShedule();
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
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
