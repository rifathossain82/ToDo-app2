import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';
import 'package:focused_menu/focused_menu.dart';


class MessageWidget extends StatefulWidget {
  //const MessageWidget({Key? key}) : super(key: key);
  MessageWidget(this.title,this.des);

  final String title;
  final String des;

  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

final firebaseDatabase = FirebaseDatabase.instance.reference();
TextEditingController _newMessageController = new TextEditingController();

class _MessageWidgetState extends State<MessageWidget> {
  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
      onPressed: (){},
      menuItems: [

        FocusedMenuItem(
            title:Text('Edit'),
            trailingIcon: Icon(Icons.edit),
            backgroundColor: Colors.green,
            onPressed:(){
              print(widget.title);
              firebaseDatabase.child("data").orderByChild("title").equalTo(widget.title).once()
                  .then((value){
                print(value);
                Map data = value.value;
                print(data);
                var key=data.keys.toString();
                print(key.substring(1,key.length-1));

                _newMessageController.text=widget.title;

                showDialog(context: context, builder: (BuildContext context){

                  return AlertDialog(
                    scrollable: true,
                    title: Text('Change Text'),
                    content: Column(
                      children: [

                        TextField(
                          controller : _newMessageController,
                          decoration: InputDecoration(
                              labelText: 'Write Text'

                          ),


                        ),



                      ],

                    ),

                    actions: [

                      ElevatedButton(
                        onPressed: ()
                        {
                          firebaseDatabase.child("data").child(key.substring(1,
                              key.length - 1))
                              .update({'title': _newMessageController.text,'des':''}).then((
                              value) {
                            print('Success');
                            Navigator.pop(context);
                          }).catchError((onError) {
                            print('Error');
                          });
                        },

                        child: Text('Update'),


                      ),




                    ],



                  );

                });


              });
            }
        ),

        FocusedMenuItem(
          title: Text('Delect'),
          trailingIcon: Icon(Icons.delete),
          backgroundColor: Colors.redAccent,
          onPressed: (){
            print(widget.title);
            firebaseDatabase.child("data").orderByChild("title").equalTo(widget.title).once()
                .then((value) {
              print(value);
              Map data = value.value;
              print(data);
              var key = data.keys.toString();
              print(key.substring(1, key.length - 1));

              firebaseDatabase.child("data").child(key.substring(1,key.length-1)).remove();

              Navigator.pop(context);

            } );

          },
        ),


      ],
      child: Center(

        child: Column(

          children: [

            Card(
              child: Row(

                children: [

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(widget.title),
                  ),


                ],



              ),




            ),
          ],
        ),
      ),
    );
  }
}




/*import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class MessageWidget extends StatefulWidget {
  final String text;
  final DateTime date;

  MessageWidget(this.text,this.date);


  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Card(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(widget.text),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              DateFormat('yyy-MM-dd, hh:mma').format(widget.date).toString(),
            ),
          ),
        ],
      ),
    );
  }
}
*/