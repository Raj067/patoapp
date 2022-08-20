import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:patoapp/backend/db/db_shedule.dart';
import 'package:patoapp/backend/models/shedules.dart';
import 'package:patoapp/backend/sync/sync_shedule.dart';
import 'package:patoapp/shedule/single_shedule.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AllShedules extends StatefulWidget {
  const AllShedules({Key? key}) : super(key: key);

  @override
  State<AllShedules> createState() => _AllShedulesState();
}

class _AllShedulesState extends State<AllShedules> {
  List<SheduleModel> _shedules = [];
  refreshDataDB() async {
    SyncShedule syncShedule = SyncShedule();
    await syncShedule.fetchData();
    fetchShedule();
  }

  // get all shedule in the database
  fetchShedule() async {
    List<Map<String, dynamic>> shedules = await DBHelperShedule.query();
    _shedules = [];
    _shedules.addAll(shedules.map((e) => fromJsonShedule(e)).toList());
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchShedule();
    refreshDataDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.allSchedule,
          style: const TextStyle(color: Colors.white),
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
      body: _allShedules(),
    );
  }

  _allShedules() {
    List<Widget> data = [Container(height: 5)];
    for (SheduleModel dx in _shedules) {
      data.add(_singleShedule(shedule: dx));
    }
    return ListView(children: data);
  }

  _singleShedule({required SheduleModel shedule}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 2.5, 10, 2.5),
      child: Card(
        color: sheduleColors[shedule.color].withAlpha(50),
        elevation: 0,
        // color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => SingleShedule(
                    shedule: shedule,
                    fetchShedule: () {
                      fetchShedule();
                    }),
                fullscreenDialog: true,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      shedule.startTime,
                      style: TextStyle(
                        fontSize: 12,
                        color: sheduleColors[shedule.color],
                      ),
                    ),
                    SvgPicture.asset(
                      "assets/svg/line1.svg",
                      width: 25,
                      height: 25,
                      color: sheduleColors[shedule.color],
                    ),
                    Text(
                      shedule.endTime,
                      style: TextStyle(
                        fontSize: 12,
                        color: sheduleColors[shedule.color],
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shedule.title.length > 20
                          ? shedule.title.replaceRange(20, null, '...')
                          : shedule.title,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: sheduleColors[shedule.color],
                      ),
                    ),
                    Container(height: 3),
                    Text(
                      shedule.description.length > 20
                          ? shedule.description.replaceRange(20, null, '...')
                          : shedule.description,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Created at ${DateFormat('d-M-yyy').format(DateTime.parse(shedule.createdAt))}",
                      style: TextStyle(
                        fontSize: 12,
                        color: sheduleColors[shedule.color],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.view,
                      style: TextStyle(
                        fontSize: 12,
                        color: sheduleColors[shedule.color],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
