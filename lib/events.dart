import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:mayan/addevent.dart';
import 'package:mayan/newEvent.dart';
import 'package:mayan/providers/eventProvider.dart';
import 'package:mayan/screens/image_screen.dart';
import 'package:mayan/screens/recording_screen.dart';
import 'package:mayan/screens/video_screen.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class EventsScreen extends StatefulWidget {
  var index;
  EventsScreen(this.index,{super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
List eventdata=[
    
  ];
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();



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
      return "June";
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


  getList(date)async{
    try{
      var box = await Hive.openBox('events');
     eventdata=await box.get(date.year.toString()+date.month.toString());
    
    setState(() {
      print("object");
    });
    }
    catch(e){
      print("hbb");
    }
    }

  eventWidget(){
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEventScreen()));
      },
      child: Padding(
      padding: const EdgeInsets.all(8.0),
      child:   Container(
      
      height: 110,
      
      decoration: BoxDecoration(color: Color.fromARGB(255, 240, 240, 240),borderRadius: BorderRadius.circular(9)),
      
      child: Row(children: [
      
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
          child: Column(
          
            children: [
          
             Text("09",style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.cyan
              ),),
    
              Text("Dec",style: TextStyle(
              fontSize: 20,
              
              ),),
    
              Text("2023",style: TextStyle(
              fontSize: 20,
              
              
              ),),
          
            ],
          
          ),
        ),
        SizedBox(width: 2,),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
          child: VerticalDivider(thickness: 2,),
        ),
    
        Column(
          children: [
            Text("Event Title",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23),),
            Text("Marriage Function",style: TextStyle(color: Colors.grey,fontSize: 23),),
            Text("Birthday Function",style: TextStyle(color: Colors.grey,fontSize: 23),)
          ],
        )
      
      ],),
      
      ),
    ),
    );
  }


  
Future<void> scheduleNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
      EventProvider eventProvider = Provider.of<EventProvider>(context, listen: false);
    
     var datee=eventProvider.eventdata[widget.index]["date"];
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    ticker: 'ticker',
  );
  var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );

  // Schedule the notification
  tz.initializeTimeZones();
  DateTime now=DateTime.now();
  await flutterLocalNotificationsPlugin.zonedSchedule(
    0, // Notification ID
    'Scheduled Title',
    'Scheduled Body',
    tz.TZDateTime.now(tz.local).add(now.difference(datee)),// Time to show
    platformChannelSpecifics,
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    // getList(widget.data["date"]);
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(
      builder: (context, eventProvider, child) {
        return Scaffold(body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.circle,color: Colors.cyan,size: 40,),
                    IconButton(onPressed: (){

                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                  
                  ]),
                  SizedBox(width: 20,),
                Text(getMonth(eventProvider.eventdata[widget.index]["date"].month)+" "+eventProvider.eventdata[widget.index]["date"].day.toString(),style: TextStyle(fontSize: 27),)
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [

                Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Container(
  
    height: 300,
  
    decoration: BoxDecoration(color: Color.fromARGB(255, 240, 240, 240),borderRadius: BorderRadius.circular(9)),
  
    child: Row(children: [
  
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Text(getMonth(eventProvider.eventdata[widget.index]["date"].month)+" "+eventProvider.eventdata[widget.index]["date"].day.toString()+" "+eventProvider.eventdata[widget.index]["date"].year.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: Colors.cyan),),
            Text(eventProvider.eventdata[widget.index]["eventTitle"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23),),
            Text(eventProvider.eventdata[widget.index]["eventDesc"],style: TextStyle(color: Colors.grey,fontSize: 23),),
            // Text("Birthday Function",style: TextStyle(color: Colors.grey,fontSize: 23),),
            Row(
              children: [
                
                Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageScreen(index:widget.index)));
                    },
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(9)),
                      height: 100,
                      width: 100,
                      child: Image.network("https://th.bing.com/th/id/OIP.Bc1vzpxOpeel3sUtvnT5UwHaEo?w=1920&h=1200&rs=1&pid=ImgDetMain",fit: BoxFit.fill,)),
                  ),
                ),
                  Text("Images")
              ],),
              
              Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RecordingScreen(index:widget.index)));
                    },
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(9)),
                      height: 100,
                      width: 100,
                      child: Image.network("https://static.thenounproject.com/png/370406-200.png")),
                  ),
                ),
                  Text("Recordings")
              ],),

              Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoScreen(index:widget.index)));
                        },
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(9)),
                          height: 100,
                          width: 100,
                          child: Image.network("https://th.bing.com/th/id/OIP.0-lYl6KTaQ7_MiNiGLsMQwHaFj?rs=1&pid=ImgDetMain")),
                      ),

                        InkWell(
                          onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoScreen(index:widget.index)));
                        },
                          child: Icon(Icons.play_arrow,size: 50,color: Color.fromARGB(255, 248, 247, 247),)),
                    ],
                  ),
                ),
                  Text("Videos")
              ],)
              ],
            ),

            InkWell(
              onTap: () {
                try{
                  scheduleNotification(flutterLocalNotificationsPlugin);
                final snackBar = SnackBar(
            content: Text('This is a SnackBar'),
            action: SnackBarAction(
              label: 'Close',
              onPressed: () {
                // Some code to execute when the user presses the action button
              },
            ),
          );

          // Show the SnackBar
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                catch(e){
                  print("object");
                }
                
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width-50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: Color.fromARGB(255, 214, 214, 214)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_month),
                      Text("Set Reminder",style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(255, 118, 118, 118)),),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )
  
    ],),
  
  ),
),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>NewEventScreen(date: eventProvider.eventdata[widget.index]["date"],)));
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
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("More Events",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                ),
                Expanded(
  child:   ListView.builder(
  
                          shrinkWrap: true,
  
                          itemCount: eventProvider.eventdata.length,
  
                          itemBuilder: (BuildContext context, int index) {
                            
                            return InkWell(
  onTap: (){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>EventsScreen(index)));
  },
  child:   Padding(
    padding: const EdgeInsets.all(8.0),
    child:   Container(
      height: 110,
      decoration: BoxDecoration(color: Color.fromARGB(255, 240, 240, 240),borderRadius: BorderRadius.circular(9)),
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
          child: Column(
            children: [
             Text(eventProvider.eventdata[index]["date"].day.toString(),style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.cyan),),
              Text(getMonth(eventProvider.eventdata[index]["date"].month),style: TextStyle(
              fontSize: 20,
              ),),Text(eventProvider.eventdata[index]["date"].year.toString(),style: TextStyle(
              fontSize: 20,),),]),),
        SizedBox(width: 2,),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
          child: VerticalDivider(thickness: 2,),
        ),
        Column(
          children: [
            Text(eventProvider.eventdata[index]["eventTitle"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23),),
            Text(eventProvider.eventdata[index]["eventDesc"],style: TextStyle(color: Colors.grey,fontSize: 23),),
            ], )],),),));
                          }),
)
              ],
            ),
          ),
        ],
      ),
    ),);});
  }
}