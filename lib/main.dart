import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mayan/adapter/fileadapter.dart';
import 'package:mayan/events.dart';
import 'package:mayan/newEvent.dart';
import 'package:mayan/providers/eventProvider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:path_provider/path_provider.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(FileAdapter());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventProvider()),
      ],
      child: MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp()),
    ),
  );
  // runApp( MaterialApp(
  //   debugShowCheckedModeBanner: false,
  //   home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  DateTime _currentDate = DateTime.now();
    EventList<Event> _markedDateMap = new EventList(events: {

    });
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat('MMMM').format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
  // List eventdata=[
    
  // ];

  List<Widget> widgList=[];

  getMonth(month){
    if(month==1){
      return "Jan";
    }
    else if(month==2){
      return "Feb";
    }
    else if(month==3){
      return "Mar";
    }
    else if(month==4){
      return "Apr";
    }
    else if(month==5){
      return "May";
    }
    else if(month==6){
      return "Jun";
    }
    else if(month==7){
      return "Jul";
    }
    else if(month==8){
      return "Aug";
    }
    else if(month==9){
      return "Sep";
    }
    else if(month==10){
      return "Oct";
    }
    else if(month==11){
      return "Nov";
    }
    else if(month==12){
      return "Dec";
    }
  }

  



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EventProvider eventProvider = Provider.of<EventProvider>(context, listen: false);
    
     eventProvider.getList(DateTime.now());
     print("object");
    // getList(DateTime.now(),context);
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(
      builder: (context, eventProvider, child) {
        return Scaffold(
        
        body: Column(
          children: [
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: IconButton(onPressed: (){
                        }, icon: Icon(Icons.search,color: Color.fromARGB(255, 113, 113, 113),size: 35,)),
              ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: IconButton(onPressed: (){
                                  
                        }, icon: Icon(Icons.menu,color: Color.fromARGB(255, 174, 174, 174),size: 35,)),
                      ),],),
            ),

//             TableCalendar(
//   firstDay: DateTime(1999),
//   focusedDay: DateTime.now(),
//   lastDay: DateTime(2100),
//   eventLoader: (day) {
//     // Return events for the given day from your _events map
//     return _events[day] ?? [];
//   },
//   calendarBuilders: CalendarBuilders(
//     markerBuilder: (context, date, events) {
//       late Widget markers = Container(); // Default to an empty container
//       print(date);
//       print(DateTime(2023,12,1));
//       print(_events[date.toLocal()]);
//       if (_events[date.toLocal()]!=null) {
//         markers = Positioned(
//           right: 1,
//           bottom: 1,
//           child: _buildEventsMarker(date, events),
//         );
//       }

//       return markers;
//     },
//   ),
// ),

Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            DateFormat('MMMM yyyy').format(_targetDateTime),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
            CalendarCarousel<Event>(
              
      todayBorderColor: Colors.blueAccent,
      selectedDayButtonColor:Color.fromARGB(93, 68, 137, 255),
      selectedDayBorderColor: Color.fromARGB(93, 68, 137, 255),
      selectedDayTextStyle:TextStyle(color: Colors.black),
      onDayPressed: (date, events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));
        // getEventData(
        //     DateTime(_targetDateTime.year, _targetDateTime.month, date.day),
        //     false);
      },

      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      // thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,

      markedDatesMap: eventProvider.markeddateMap,
      childAspectRatio: 1.5,
      height: 250.0,
      // height: 200.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      // customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder: CircleBorder(
        side: BorderSide(color: Colors.blueAccent),
      ),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 12,
        color: Colors.blueAccent,
      ),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: Colors.white,
      ),
      todayButtonColor: Colors.blueAccent,
      
      minSelectedDate: DateTime.parse("2010-01-01"),
      maxSelectedDate: _currentDate.add(Duration(days: 730)),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.pinkAccent,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.tealAccent,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        eventProvider.getList(date);
        this.setState(() {
          _targetDateTime = date;
          // yearDropdownValue = _targetDateTime.year;
          print(date.toString());
          _currentMonth = DateFormat('MMMM').format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    ),
SizedBox(height: 10,),
Expanded(
  child:   ListView.builder(
  
  
                          itemCount: 
                          eventProvider.event.length+1,
  
                          itemBuilder: (BuildContext context, int index) {
                            if(index==eventProvider.event.length){
                              return Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 40),
                  child: InkWell(
                    onTap: () {
                      // setEvent(DateTime.now(), "eventtitle", "eventdesc");
                      eventProvider.temporaryimagetoadd=[];
                      eventProvider.temporaryaudiotoadd=[];
                      eventProvider.temporaryvideotoadd=[];
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>NewEventScreen(date: _currentDate2,)));
                    },
                    child: Container(
                      decoration: BoxDecoration(color: Colors.cyan,borderRadius: BorderRadius.circular(9)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 30,),
                              Text('Add Event',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),),
                              SizedBox(width: 30,),
                              Icon(Icons.add,color: Colors.white,size: 40,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
                            }
                            return InkWell(
  onTap: (){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>EventsScreen(index)));
  },
  child:   Padding(
    padding: const EdgeInsets.only(top: 8,left: 8,bottom: 8,right: 8),
    child:   Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(onPressed: ()async{
              eventProvider.deleteEvent(eventProvider.event[index]["date"],index);

            }, icon: Icon(Icons.close)),
          ],
        ),
        Container(
          height: 110,
          decoration: BoxDecoration(color: Color.fromARGB(255, 240, 240, 240),borderRadius: BorderRadius.circular(9)),
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: Column(
                children: [
                 Text(eventProvider.event[index]["date"].day.toString(),style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan),),
                  Text(getMonth(eventProvider.event[index]["date"].month),style: TextStyle(
                  fontSize: 20,
                  ),),Text(eventProvider.event[index]["date"].year.toString(),style: TextStyle(
                  fontSize: 20,),),]),),
            SizedBox(width: 2,),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
              child: VerticalDivider(thickness: 2,),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  Text(eventProvider.event[index]["eventTitle"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23),),
                  Text(eventProvider.event[index]["eventDesc"],style: TextStyle(color: Colors.grey,fontSize: 23),),
                  ], ),
            )],),),
      ],
    ),));
                          }),
)
          ],
        ),
      
    );});
  }



// getList(date,context)async{
//     try{
//       var box = await Hive.openBox('events');
//       // box.clear();
//       EventProvider eventProvider = Provider.of<EventProvider>(context, listen: false);
//      eventProvider.getList(date);
//     print("object");
    
//     eventProvider.getList(date);
//     setState(() {
//       print("object");
//     });
//     }
//     catch(e){
//       print("hbb");
//     }
//     }

    // setEvent(date,eventtitle,eventdesc)async{
    // try{
    //   var box = await Hive.openBox('events');
    //   var event=await box.get(date.year.toString()+date.month.toString());
    //   if(event==null){
    //     event=[];
    //   }
    //   event.add({"date":date,"eventTitle":eventtitle,"eventDesc":eventdesc});
    // await box.put(date.year.toString()+date.month.toString(), event);
    // await getList(date,context);
    // setState(() {
    //   print("object");
    // });
    // }
    // catch(e){
    //   print("hbb");
    // }
    // }


  Widget _buildEventsMarker(DateTime date, List events) {
  return Row(
    children: events
        .map(
          (event) => Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            width: 5.0,
            height: 5.0,
          ),
        )
        .toList(),
  );
}
}
