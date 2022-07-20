import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:patoapp/backend/controllers/shedules_controller.dart';
import 'package:patoapp/backend/models/shedules.dart';
import 'package:patoapp/themes/light_theme.dart';

class AddSheduleNew extends StatefulWidget {
  final Function fetchShedule;
  const AddSheduleNew({Key? key, required this.fetchShedule}) : super(key: key);

  @override
  State<AddSheduleNew> createState() => _AddSheduleNewState();
}

class _AddSheduleNewState extends State<AddSheduleNew> {
  final addSheduleFormKey = GlobalKey<FormState>();
  final SheduleController _sheduleController = Get.put(SheduleController());
  TextEditingController myTitle = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController sheduleDate = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();

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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: addSheduleFormKey,
          child: ListView(
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
                    controller: startTime,
                    //editing controller of this TextField
                    decoration: const InputDecoration(
                      suffixIcon: Icon(
                        Icons.timelapse,
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
                          startTime.text = pickedTime.format(context);
                          // .toString(); //set output date to TextField value.
                        });
                      } else {}
                    },
                  ),
                ),
                Container(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: endTime,
                    //editing controller of this TextField
                    decoration: const InputDecoration(
                      suffixIcon: Icon(
                        Icons.timelapse,
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
                          endTime.text = pickedTime.format(context);
                          // .toString(); //set output date to TextField value.
                        });
                      } else {}
                    },
                  ),
                ),
              ]),
            ],
          ),
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
                    _addSheduleToDB();
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

  _addSheduleToDB() async {
    Navigator.pop(context);
    SheduleModel shedule = SheduleModel(
      startTime: startTime.text,
      description: description.text,
      endTime: endTime.text,
      dateEvent: sheduleDate.text,
      title: myTitle.text,
      isCompleted: 0,
    );

    await _sheduleController.addShedule(shedule);
    // print(value);
    widget.fetchShedule();
  }
}
