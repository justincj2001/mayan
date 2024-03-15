import 'package:flutter/material.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
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
                  Text("December 15",style: TextStyle(fontSize: 24),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text("   Add Malayalam Month and Date",style: TextStyle(fontSize: 21,color: Colors.grey),),
                      height: 50,
                      decoration: BoxDecoration(color: Color.fromARGB(255, 243, 243, 243),borderRadius: BorderRadius.circular(9)),),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text("   Event Title",style: TextStyle(fontSize: 21,color: Colors.grey),),
                      height: 50,
                      decoration: BoxDecoration(color: Color.fromARGB(255, 243, 243, 243),borderRadius: BorderRadius.circular(9)),),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text("   Details",style: TextStyle(fontSize: 21,color: Colors.grey),),
                      height: 50,
                      decoration: BoxDecoration(color: Color.fromARGB(255, 243, 243, 243),borderRadius: BorderRadius.circular(9)),),
                  ),
                  Text("Add Fields",style: TextStyle(fontSize: 24),),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 140,
                            width: 170,
                            decoration: BoxDecoration(color: Color.fromARGB(255, 219, 219, 219),borderRadius: BorderRadius.circular(9)),
                            child: Icon(Icons.add,size: 70,color: Colors.grey,),
                          ),
                          Text("Images",style: TextStyle(color: Colors.grey,fontSize: 22),)
                        ],
                      ),
                      SizedBox(width: 10,),
                      Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 140,
                        width: 170,
                        decoration: BoxDecoration(color: Color.fromARGB(255, 219, 219, 219),borderRadius: BorderRadius.circular(9)),
                        child: Icon(Icons.add,size: 70,color: Colors.grey,),
                      ),
                      Text("Recordings",style: TextStyle(color: Colors.grey,fontSize: 22),)
                    ],
                  )

                  
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),);
  }
}