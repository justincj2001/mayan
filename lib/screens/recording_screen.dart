import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive/hive.dart';
import 'package:mayan/providers/eventProvider.dart';
import 'package:mayan/screens/add_files_image.dart';
import 'package:mayan/screens/add_files_recording.dart';
import 'package:mayan/widgets/audioplayer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class RecordingScreen extends StatefulWidget {
  // var data;
  var index;
  
  RecordingScreen({super.key,this.index});

  @override
  State<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
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
    setState(() {
      print("object");
    });
    }
    catch(e){
      print("hbb");
    }
    }

  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(
      builder: (context, eventProvider, child) {
        return Scaffold(
      body: ListView(
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
                Text("Recordings",style: TextStyle(fontSize: 27),)
              ],
            ),
          ),
          widget.index==null?eventProvider.temporaryaudiotoadd.length==0?Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 400,
                child: Image.network("https://cdn3d.iconscout.com/3d/premium/thumb/no-data-found-4810740-4009512.png"),),
                InkWell(
                  onTap: () {
                    if(widget.index==null)
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddFilesRecordingScreen()));
                    else
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddFilesRecordingScreen()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 140,
                    decoration: BoxDecoration(color: Colors.cyan,borderRadius: BorderRadius.circular(9)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.add),
                          Text("Add Recordings",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    )),
                )
            ],
          ):Container(
            height: MediaQuery.of(context).size.height-120,
            child: ListView.builder(
            
                            shrinkWrap: true,
            
                            itemCount: eventProvider.temporaryaudiotoadd.length+1,
            
                            itemBuilder: (BuildContext context, int index) {
                              if(index==eventProvider.temporaryaudiotoadd.length){
                                return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddFilesRecordingScreen()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(color: Colors.cyan,borderRadius: BorderRadius.circular(9)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.add),
                            Text("Add Recordings",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      )),
                  );
                              }
                              return Container(
                                height: 70,
                                child: AudioPlayerWidget(audioFilePath: eventProvider.temporaryaudiotoadd[index].path)
);
                            })):
          eventProvider.eventdata[widget.index]["eventAudios"].length==0?Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 400,
                child: Image.network("https://cdn3d.iconscout.com/3d/premium/thumb/no-data-found-4810740-4009512.png"),),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddFilesRecordingScreen(data:eventProvider.eventdata[widget.index],index:widget.index)));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 140,
                    decoration: BoxDecoration(color: Colors.cyan,borderRadius: BorderRadius.circular(9)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.add),
                          Text("Add Recordings",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    )),
                )
            ],
          ):
          Container(
            height: MediaQuery.of(context).size.height-120,
            child: ListView.builder(
            
                            shrinkWrap: true,
            
                            itemCount: eventProvider.eventdata[widget.index]["eventAudios"].length+1,
            
                            itemBuilder: (BuildContext context, int index) {
                              if(index==eventProvider.eventdata[widget.index]["eventAudios"].length){
                                return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddFilesRecordingScreen(data:eventProvider.eventdata[widget.index],index:widget.index)));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(color: Colors.cyan,borderRadius: BorderRadius.circular(9)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.add),
                            Text("Add Recordings",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      )),
                  );
                              }
                              return Container(
                                height: 70,
                                child: AudioPlayerWidget(audioFilePath: eventProvider.eventdata[widget.index]["eventAudios"][index].path)
);
                            }),
          )
        ],
      ),
    );});
  }
}