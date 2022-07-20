import 'package:get/get.dart';
import 'package:patoapp/backend/db/db_helper.dart';
import 'package:patoapp/backend/models/shedules.dart';

class SheduleController extends GetxController {
  // @override
  // void onReady() {
  //   super.onReady();
  // }
  var sheduleList = [];

  Future<int> addShedule(SheduleModel shedule) async {
    return await DBHelper.insertDb(shedule);
  }

  // get all shedule in the database
  Future<List<SheduleModel>> getShedules() async {
    List<Map<String, dynamic>> shedules = await DBHelper.query();
    return shedules
        .map((e) => SheduleModel(
            id: e['id'],
            dateEvent: e['dateEvent'],
            endTime: e['endTime'],
            startTime: e['startTime'],
            title: e['title'],
            description: e['description'],
            isCompleted: e['isCompleted'] ?? 0))
        .toList();
  }
}
