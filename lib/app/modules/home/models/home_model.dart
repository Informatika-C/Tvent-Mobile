import 'package:tvent/app/models/event_model.dart';

class HomeModel {
  List<EventModel>? newEvents = [];
  List<EventModel>? popularEvents = [];
  EventModel? nearestEvent;
  int? nearestEventTime = 0;
  HomeModel({
    this.newEvents,
    this.popularEvents,
    this.nearestEvent,
    this.nearestEventTime,
  });
}
