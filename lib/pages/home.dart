 import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 
 
 class HomePage extends StatefulWidget {
 
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    new Band(id:'1', name:'Metallica',votes: 5),
    new Band(id:'2', name:'Bon Jovi',votes: 5),
    new Band(id:'3', name:'Slipknot',votes: 5),
    new Band(id:'4', name:'Rammstein',votes: 5),
    new Band(id:'5', name:'Cold Kingdom',votes: 5),
  ];

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar:AppBar(
         title: Text('Band Names', style: TextStyle(color: Colors.black87),),
         centerTitle: true,
         elevation: 1,
         backgroundColor: Colors.white,
       ),
       body: ListView.builder(
         physics: BouncingScrollPhysics(),
         itemCount: bands.length,
         itemBuilder: (BuildContext context, int index) {
           return _bandTile(bands[index]);
           },),
           floatingActionButton: FloatingActionButton(
             child: Icon(Icons.add),
             elevation: 1,
             onPressed: addNewBand,
           ),
    );
   }

   Widget  _bandTile(Band banda) {
     return Dismissible(
       key: Key(banda.id),
       direction: DismissDirection.startToEnd,
       onDismissed: (direction){
         print('direction : $direction');
         print('banda : ${banda.name}');
       },
       background: Container(
         padding: EdgeInsets.only(left: 8.0),
         color: Colors.red,
         child: Align(
           alignment: Alignment.centerLeft,
           child: Icon(Icons.delete, color: Colors.white,)),
       ),
       child: ListTile(
             leading: CircleAvatar(
               child: Text(banda.name.substring(0,2)), //primeras dos letras 
               backgroundColor: Colors.blue[100],
             ),
             title: Text(banda.name),
             trailing: Text('${banda.votes}', style: TextStyle(fontSize: 20),),
             onTap: (){
               print(banda.name);
             },
           ),
     );
   }
//en el statefull widget, el context esta de manera global, por lo que no es necesario mandarlo
  addNewBand(){
    final textController = new  TextEditingController();
    if( Platform.isAndroid ){
      //Android
      showDialog(
      context: context,
       builder: (BuildContext context){
         return AlertDialog(
           title: Text('new band name'),
           content: TextField(
             controller: textController,

           ),
           actions: [
             MaterialButton(
               child: Text('add'),
               elevation: 5,
               textColor: Colors.blue,
               onPressed: ()=>addBandName(textController.text))
           ],
         );
       },

       );
    }else{
    showCupertinoDialog(
      context: context,
      builder: ( _ ){
        return CupertinoAlertDialog(
          title:Text('New band name'),
          content:TextField(
            controller:textController
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Add'),
              onPressed: ()=>addBandName(textController.text),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text('Dismiss'),
              onPressed: ()=>Navigator.pop(context),
            )
          ],
        );
      });}
    
  }

  void addBandName(String name){
    if(name.length > 1 ){
      //podemos agregar
      this.bands.add( new Band(id:DateTime.now().toString(), name: name, votes: 0));
    setState(() {
      
    });
    }
    

    print(name);

    Navigator.pop(context);

  }

}