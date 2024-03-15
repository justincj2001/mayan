import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mayan/main.dart';
import 'package:mayan/providers/eventProvider.dart';
import 'package:mayan/screens/image_screen.dart';
import 'package:mayan/screens/recording_screen.dart';
import 'package:mayan/screens/video_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class NewEventScreen extends StatefulWidget {
  var date;
  NewEventScreen({super.key,this.date});

  @override
  State<NewEventScreen> createState() => _NewEventScreenState();
}

class _NewEventScreenState extends State<NewEventScreen> {
  DateTime selectedDate=DateTime.now();
  TextEditingController titleController=TextEditingController();
  TextEditingController descController=TextEditingController();
  late List<File> files;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }


  

  



//   setEvent(date,eventtitle,eventdesc)async{
//     try{
//       var box = await Hive.openBox('events');
      
//       var event=await box.get(date.year.toString()+date.month.toString());
//       if(event==null){
//         event=[];
//       }
//       Directory appDocDir = await getApplicationDocumentsDirectory();
// String appDocPath = appDocDir.path;
//       // for(int i=0;i<files.length;i++){
      
//       // }
//       event.add({"date":date,"eventTitle":eventtitle,"eventDesc":eventdesc,"eventImages":[],"eventAudios":[],"eventVideos":[]});
//     await box.put(date.year.toString()+date.month.toString(), event);
//     setState(() {
//       print("object");
//     });
//     }
//     catch(e){
//       print("hbb");
//     }
//     }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.date!=null){
      selectedDate=widget.date;
      setState(() {
        
      });
      }
  }


  
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


  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(
      builder: (context, eventProvider, child) {
        return Scaffold(
      body:SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  Text("Add Event",style: TextStyle(fontSize: 27),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(getMonth(selectedDate.month)+" "+selectedDate.day.toString(),style: TextStyle(fontSize: 24),),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //     alignment: Alignment.centerLeft,
                  //     child: Text("   Add Malayalam Month and Date",style: TextStyle(fontSize: 21,color: Colors.grey),),
                  //     height: 50,
                  //     decoration: BoxDecoration(color: Color.fromARGB(255, 243, 243, 243),borderRadius: BorderRadius.circular(9)),),
                  // ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        decoration: InputDecoration.collapsed(
        hintText: "  Event Title",
        border: InputBorder.none,
      ),
                        controller: titleController,style: TextStyle(fontSize: 21,color: Color.fromARGB(255, 87, 87, 87)),),
                      height: 50,
                      decoration: BoxDecoration(color: Color.fromARGB(255, 243, 243, 243),borderRadius: BorderRadius.circular(9)),),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        decoration: InputDecoration.collapsed(
        hintText: "  Details",
        border: InputBorder.none,
      ),
                        controller: descController,style: TextStyle(fontSize: 21,color: Colors.grey),),
                      height: 50,
                      decoration: BoxDecoration(color: Color.fromARGB(255, 243, 243, 243),borderRadius: BorderRadius.circular(9)),),
                  ),
                  // Text("Add Fields",style: TextStyle(fontSize: 24),),
                  // SizedBox(height: 20,),
                  // Row(
                  //   children: [
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Container(
                  //           height: 140,
                  //           width: 170,
                  //           decoration: BoxDecoration(color: Color.fromARGB(255, 219, 219, 219),borderRadius: BorderRadius.circular(9)),
                  //           child: Icon(Icons.add,size: 70,color: Colors.grey,),
                  //         ),
                  //         Text("Images",style: TextStyle(color: Colors.grey,fontSize: 22),)
                  //       ],
                  //     ),
                  //     SizedBox(width: 10,),
                  //     Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Container(
                  //       height: 140,
                  //       width: 170,
                  //       decoration: BoxDecoration(color: Color.fromARGB(255, 219, 219, 219),borderRadius: BorderRadius.circular(9)),
                  //       child: Icon(Icons.add,size: 70,color: Colors.grey,),
                  //     ),
                  //     Text("Recordings",style: TextStyle(color: Colors.grey,fontSize: 22),)
                  //   ],
                  // )

                  
                  //   ],
                  // ),
                  SizedBox(height: 30,),
                  Row(
              children: [
                
                Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageScreen()));
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RecordingScreen()));
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
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoScreen()));
                        },
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(9)),
                          height: 100,
                          width: 100,
                          child: Image.network("https://th.bing.com/th/id/OIP.0-lYl6KTaQ7_MiNiGLsMQwHaFj?rs=1&pid=ImgDetMain")),
                      ),

                        InkWell(
                          onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoScreen()));
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
                      onTap: () async{
                        // await setEvent(selectedDate, titleController.text, descController.text);
                        await eventProvider.setEvent(selectedDate, titleController.text, descController.text);
                        await eventProvider.getList(selectedDate);
                        Navigator.pop(context);
                      },
                      child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 300,child: Text("Submit",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 26),),decoration: BoxDecoration(color: Colors.cyan,borderRadius: BorderRadius.circular(9)),),)
                ],
              ),
            )
          ],
        ),
      ),
    )
      
      
      
//       Column(
//         mainAxisAlignment: MainAxisAlignment.center,
        
//         children: [
//           Row(
//               children: [
//                 Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     Icon(Icons.circle,color: Colors.cyan,size: 40,),
//                     IconButton(onPressed: (){
//                       Navigator.pop(context);
//                     }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                  
//                   ]),
//                   SizedBox(width: 20,),
//                 Text("Add Event",style: TextStyle(fontSize: 27),)
//               ],
//             ),
//           Container(
//             decoration: BoxDecoration(border: Border.all()),
//             width: double.infinity,
//             child: Padding(
//               padding: const EdgeInsets.all(28.0),
//               child: Column(
//                 children: [
                  
//                   SizedBox(height: 20,),
//                   InkWell(
//                     onTap: () {
//                       _selectDate(context);
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text("Event Date: ",style: TextStyle(fontWeight: FontWeight.bold),),
//                         SizedBox(width: 20,),
//                         Icon(Icons.date_range),
//                         SizedBox(width: 20,),
//                         Text(selectedDate.day.toString()+"-"+selectedDate.month.toString()+"-"+selectedDate.year.toString())
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 40,),
//                   Text("Event Title: ",style: TextStyle(fontWeight: FontWeight.bold),),
//                   TextField(controller: titleController,),
//                     SizedBox(height: 50,),
//                     Text("Event Description: ",style: TextStyle(fontWeight: FontWeight.bold),),
//                   TextField(controller: descController,),
            
//                     SizedBox(height: 20,),
//                     Container(
//                       child: IconButton(onPressed: ()async{
//                         FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

// if (result != null) {
//    files = result.paths.map((path) => File(path!)).toList();
// } else {
//   // User canceled the picker
// }
//                       }, icon: Icon(Icons.image,size: 50,),),
//                     ),
//                     SizedBox(height: 20,),
//                     InkWell(
//                       onTap: () async{
//                         // await setEvent(selectedDate, titleController.text, descController.text);
//                         await eventProvider.setEvent(selectedDate, titleController.text, descController.text);
//                         await eventProvider.getList(selectedDate);
//                         Navigator.pop(context);
//                       },
//                       child: Container(
//                       alignment: Alignment.center,
//                       height: 40,
//                       width: 300,child: Text("Submit",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),decoration: BoxDecoration(color: Color.fromARGB(163, 33, 149, 243),borderRadius: BorderRadius.circular(9)),),)
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),



    );});
  }
}