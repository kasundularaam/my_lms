import 'dart:developer';

import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher.dart';

class CalandarRepo {
  static const scopes = const [CalendarApi.calendarScope];
  static const clId =
      "1065071498530-hn17ikus8k2iph6o1271b9h1skes4pv9.apps.googleusercontent.com";
  static Future<String?> addEventForAContent({required Event event}) async {
    try {
      var clientId = new ClientId(clId, "");
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

  static Future<List<String?>> addModEveToCal(
      {required List<Event> events}) async {
    try {
      var clientId = new ClientId(clId, "");
      AuthClient authClient =
          await clientViaUserConsent(clientId, scopes, userPrompt);
      var calendar = CalendarApi(authClient);
      CalendarList calendarList = await calendar.calendarList.list();
      print("CALENDAR LIST: $calendarList");
      String calendarId = "primary";
      List<String?> eventsIds = [];
      events.forEach((singleEvent) async {
        Event addedEvent =
            await calendar.events.insert(singleEvent, calendarId);
        if (addedEvent.status == "confirmed") {
          log('Event added in google calendar');
          eventsIds.add(addedEvent.id);
        } else {
          log("Unable to add event in google calendar");
          eventsIds.add("");
        }
      });
      return eventsIds;
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
