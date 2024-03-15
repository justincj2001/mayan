import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive/hive.dart';
import 'package:mayan/providers/eventProvider.dart';
import 'package:mayan/widgets/audioplayer.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class AddFilesRecordingScreen extends StatefulWidget {
  var data;
  var index;
  AddFilesRecordingScreen(this.data,this.index,{super.key});

  @override
  State<AddFilesRecordingScreen> createState() => _AddFilesRecordingScreenState();
}

class _AddFilesRecordingScreenState extends State<AddFilesRecordingScreen> {
  late List<File> files=[];

//   updateEvent(DateTime date, String eventTitle, String eventDesc, int index,context) async {
//   try {
//     var box = await Hive.openBox('events');
//     var events = await box.get(date.year.toString() + date.month.toString());

//     // If events list is not found for the specified month, create a new list
//     if (events == null) {
//       events = [];
//     }

//     // Ensure that the index is within the bounds of the events list
//     if (index >= 0 && index < events.length) {
//       // Update the event at the specified index
//       events[index] = {
//         "date": date,
//         "eventTitle": eventTitle,
//         "eventDesc": eventDesc,
//         "eventImages": files, // assuming files is defined elsewhere
//         "eventAudios": [],
//         "eventVideos": []
//       };

//       // Put the updated list back into the box
//       await box.put(date.year.toString() + date.month.toString(), events);

//       // Print for debugging
//       print("Event updated successfully");

//       // Trigger a UI update if needed
//       EventProvider eventProvider = Provider.of<EventProvider>(context, listen: false);
//     } else {
//       // Handle index out of bounds error
//       print("Index out of bounds");
//     }
//   } catch (e) {
//     print("Error: $e");
//   }
// }


    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFiles();
  }

  getFiles()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

if (result != null) {
  files = result.paths.map((path) => File(path!)).toList();
} else {
  // User canceled the picker
}
setState(() {
  
});
  }

  addFiles()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

if (result != null) {
  result.paths.forEach((element) { 
    files.add(File(element!));
  });
} else {
  // User canceled the picker
}
setState(() {
  
});
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
                Text("Add File",style: TextStyle(fontSize: 27),),
                Expanded(child: Container()),
                InkWell(
                  onTap: () async{
                    await eventProvider.updateEventRecording(eventProvider.eventdata[widget.index]["date"], eventProvider.eventdata[widget.index]["eventTitle"], eventProvider.eventdata[widget.index]["eventDesc"], widget.index, files);
                    await eventProvider.getList(eventProvider.eventdata[widget.index]["date"]);
                    Navigator.pop(context);
                    // setEvent(widget.data["date"], widget.data["eventTitle"], widget.data["eventDesc"],widget.index,context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(9),color: Colors.cyan),
                    child: Text("SUBMIT",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold))),
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height-120,
            child: ListView.builder(
                                  
                              shrinkWrap: true,
                                  
                              itemCount: files.length+1,
                                  
                              itemBuilder: (BuildContext context, int index) {
                                if(index==files.length){
                                  return InkWell(
            onTap: () {
              addFiles();
            },
            child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 100,
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
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(9),color: Colors.cyan[50]),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(),
                                  Container(
                                    height: 100,
                                    child: AudioPlayerWidget(audioFilePath: files[index].path)),
                                    IconButton(onPressed: (){
                                      files.removeAt(index);
                                      setState(() {
                                        
                                      });
                                    }, icon: Icon(Icons.close))
                                ],
                              ),
                              Text(basename(files[index].path.toString())),
                            ],
                          )),
                      );
                              }),
                      )
        ],
      ),
    );});
  }
}