import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/controllers/shedules_controller.dart';
import 'package:patoapp/backend/db/db_shedule.dart';
import 'package:patoapp/backend/models/shedules.dart';

class SyncShedule {
  final SheduleController _sheduleController = Get.put(SheduleController());
  fetchData() async {
    String accessToken = await storage.read(key: 'access') ?? "";
    try {
      // Financial data
      var data = await http.get(
        Uri.parse("${baseUrl}api/shedule-details/"),
        headers: getAuthHeaders(accessToken),
      );
      if (data.statusCode == 200) {
        for (var dx in jsonDecode(data.body)) {
          SheduleModel myData = SheduleModel(
            id: dx['id'],
            startTime: dx['startTime'],
            description: dx['description'],
            endTime: dx['endTime'],
            dateEvent: dx['dateEvent'],
            title: dx['title'],
            isCompleted: 0,
            color: dx['color'],
            remind: dx['remind'],
            repeat: dx['repeat'],
            createdAt: dx['created_at'],
          );
          // Add data to the database
          try {
            await _sheduleController.addShedule(myData);
          } catch (e) {
            // else update existing data
            await _sheduleController.updateShedule(myData);
          }
        } // Check if data is present in the
        // server database but not in the local database
        //  == Deleting the data that is no longer stored in the database.
        List<Map<String, dynamic>> shedule = await DBHelperShedule.query();
        List<SheduleModel> localDb = [];
        localDb.addAll(shedule.map((e) => fromJsonShedule(e)).toList());
        List<dynamic> serverDb =
            jsonDecode(data.body).map((e) => e['id']).toList();

        for (SheduleModel dx in localDb) {
          if (!serverDb.contains(dx.id)) {
            // If data present in the local database
            //but not on the server delete it deleteCustomer
            await _sheduleController.deleteShedule(dx);
          }
        }
      }
    } catch (e) {
      // Thereis no internent
    }
  }
}
