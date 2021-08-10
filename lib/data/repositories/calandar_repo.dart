import 'dart:developer';

import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher.dart';

class CalandarRepo {
  static const scopes = const [CalendarApi.calendarScope];
  static Future<String?> addEvent(Event event) async {
    try {
      var clientId = new ClientId(
          "1065071498530-hn17ikus8k2iph6o1271b9h1skes4pv9.apps.googleusercontent.com",
          "");
      AuthClient authClient =
          await clientViaUserConsent(clientId, scopes, userPrompt);
      var calendar = CalendarApi(authClient);
      CalendarList calendarList = await calendar.calendarList.list();
      print("CALENDAR LIST: $calendarList");
      String calendarId = "primary";
      Event returningEvent = await calendar.events.insert(event, calendarId);
      if (returningEvent.status == "confirmed") {
        log('Event added in google calendar');
        return returningEvent.id;
      } else {
        log("Unable to add event in google calendar");
        return null;
      }
    } catch (e) {
      throw e;
    }
  }

  static void userPrompt(String url) async {
    print("Please go to the following URL and grant access:");
    print("  => $url");
    print("");

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
