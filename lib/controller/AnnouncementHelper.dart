import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementHelper {
  static Future<Set<String>> loadClickedAnnouncements() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('clickedAnnouncements')?.toSet() ?? {};
  }

  static Future<void> saveClickedAnnouncements(Set<String> clickedAnnouncements) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('clickedAnnouncements', clickedAnnouncements.toList());
  }

  static Future<Set<String>> loadDeletedAnnouncements() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('deletedAnnouncements')?.toSet() ?? {};
  }

  static Future<void> saveDeletedAnnouncements(Set<String> deletedAnnouncements) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('deletedAnnouncements', deletedAnnouncements.toList());
  }

  static Future<bool> checkUnreadAnnouncements(Set<String> clickedAnnouncements, Set<String> deletedAnnouncements) async {
    var querySnapshot = await FirebaseFirestore.instance.collection('announcement').get();
    for (var doc in querySnapshot.docs) {
      if (!clickedAnnouncements.contains(doc.id) && !deletedAnnouncements.contains(doc.id)) {
        return true;
      }
    }
    return false;
  }
}
