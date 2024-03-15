import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

class EventProvider with ChangeNotifier {
  var eventdata=[];
  EventList<Event>? markeddateMap = EventList<Event>(
      events: {},
    );
  List temp=[];
  List get event => eventdata;


  getList(date)async{
    try{
      eventdata=[];
      markeddateMap!.clear();
      var box = await Hive.openBox('events');
      // box.clear();
     eventdata=await box.get(date.year.toString()+date.month.toString());
     for(int i=0;i<eventdata.length;i++){
      _addEvent(eventdata[i]["date"],eventdata[i]["eventTitle"]);
     }
     
    print("object");
    notifyListeners();
    }
    catch(e){
      print("hbb");
    }
    }


  //   void _addEvent(DateTime date, String title) {
  //   markeddateMap!.add(date, Event(date: date, title: title));
    
  // }


    void _addEvent(DateTime date, String title) {
    markeddateMap!.addAll(date, [
      Event(
        date: date,
        title: title,
      )
    ]);
  }


    
    deleteEvent(date,index)async{
    try{
      var box = await Hive.openBox('events');
      
      var event=await box.get(date.year.toString()+date.month.toString());
      if(event==null){
        event=[];
      }
      Directory appDocDir = await getApplicationDocumentsDirectory();
String appDocPath = appDocDir.path;
      // for(int i=0;i<files.length;i++){
      
      // }
      event.removeAt(index);
    await box.put(date.year.toString()+date.month.toString(), event);
    getList(date);
    }
    catch(e){
      print("hbb");
    }
    }


    setEvent(date,eventtitle,eventdesc)async{
    try{
      var box = await Hive.openBox('events');
      
      var event=await box.get(date.year.toString()+date.month.toString());
      if(event==null){
        event=[];
      }
      Directory appDocDir = await getApplicationDocumentsDirectory();
String appDocPath = appDocDir.path;
      // for(int i=0;i<files.length;i++){
      
      // }
      event.add({"date":date,"eventTitle":eventtitle,"eventDesc":eventdesc,"eventImages":[],"eventAudios":[],"eventVideos":[]});
    await box.put(date.year.toString()+date.month.toString(), event);
    
    }
    catch(e){
      print("hbb");
    }
    }



    updateEventImage(DateTime date, String eventTitle, String eventDesc, int index,files) async {
  try {
    var box = await Hive.openBox('events');
    var events = await box.get(date.year.toString() + date.month.toString());

    // If events list is not found for the specified month, create a new list
    if (events == null) {
      events = [];
    }

    // Ensure that the index is within the bounds of the events list
    if (index >= 0 && index < events.length) {
      // Update the event at the specified index
      events[index] = {
        "date": date,
        "eventTitle": eventTitle,
        "eventDesc": eventDesc,
        "eventImages": files, // assuming files is defined elsewhere
        "eventAudios": [],
        "eventVideos": []
      };

      // Put the updated list back into the box
      await box.put(date.year.toString() + date.month.toString(), events);
      

      // Trigger a UI update if needed
    } else {
      // Handle index out of bounds error
      print("Index out of bounds");
    }
  } catch (e) {
    print("Error: $e");
  }
}



updateEventRecording(DateTime date, String eventTitle, String eventDesc, int index,files) async {
  try {
    var box = await Hive.openBox('events');
    var events = await box.get(date.year.toString() + date.month.toString());

    // If events list is not found for the specified month, create a new list
    if (events == null) {
      events = [];
    }

    // Ensure that the index is within the bounds of the events list
    if (index >= 0 && index < events.length) {
      // Update the event at the specified index
      events[index] = {
        "date": date,
        "eventTitle": eventTitle,
        "eventDesc": eventDesc,
        "eventImages": [], // assuming files is defined elsewhere
        "eventAudios": files,
        "eventVideos": []
      };

      // Put the updated list back into the box
      await box.put(date.year.toString() + date.month.toString(), events);
      

      // Trigger a UI update if needed
    } else {
      // Handle index out of bounds error
      print("Index out of bounds");
    }
  } catch (e) {
    print("Error: $e");
  }
}





updateEventVideo(DateTime date, String eventTitle, String eventDesc, int index,files) async {
  try {
    var box = await Hive.openBox('events');
    var events = await box.get(date.year.toString() + date.month.toString());

    // If events list is not found for the specified month, create a new list
    if (events == null) {
      events = [];
    }

    // Ensure that the index is within the bounds of the events list
    if (index >= 0 && index < events.length) {
      // Update the event at the specified index
      events[index] = {
        "date": date,
        "eventTitle": eventTitle,
        "eventDesc": eventDesc,
        "eventImages": [], // assuming files is defined elsewhere
        "eventAudios": [],
        "eventVideos": files
      };

      // Put the updated list back into the box
      await box.put(date.year.toString() + date.month.toString(), events);
      

      // Trigger a UI update if needed
    } else {
      // Handle index out of bounds error
      print("Index out of bounds");
    }
  } catch (e) {
    print("Error: $e");
  }
}

  
}