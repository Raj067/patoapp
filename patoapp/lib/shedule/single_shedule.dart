import 'package:flutter/material.dart';
import 'package:patoapp/backend/models/shedules.dart';
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
      body: const Center(
        child: Text("Daybook"),
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
    );
  }

  _sheduleCompleted(BuildContext context) async {
    widget.fetchShedule();
    Navigator.pop(context);
  }
}
