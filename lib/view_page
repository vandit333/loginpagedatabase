import 'package:flutter/material.dart';
import 'package:loginpagedatabase/data.dart';
// import 'package:login_id/data.dart';
import 'package:sqflite/sqflite.dart';

import 'insert_page.dart';

class view_page extends StatefulWidget {
  const view_page({Key? key}) : super(key: key);

  @override
  State<view_page> createState() => _view_pageState();
}

class _view_pageState extends State<view_page> {

  Database? db;
  List<Map> list=[];
  bool fav =false;
  String qry = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getalldata();

  }

  getalldata()
  {
    data().createDatabase().then((value) async{
      db = value;
      if(fav==false)
        {
           qry = "select * from form";
        }
      else{
         qry = "select * from form where fav = '1'";
      }

      list = await db!.rawQuery(qry);
      print(list);

      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
           setState(() {
             fav=!fav;

           });
           getalldata();
          }, icon: fav ? Icon(Icons.star_border) : Icon(Icons.star))
        ],
      ),
      body: ListView.separated(
        itemCount: list.length,
        itemBuilder: (context, index) {
        Map m = list[index];
        return ListTile(

          // leading: Text("${m['id']}"),  // id
          leading: Text("${index}"),
          title: Text("${m['name']}"),
          subtitle: Column(children: [
            Text("Number=${m['number']}"),
            Text("Email=${m['email']}"),
          ],),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(onPressed: () async {

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return insert_page(type: "update",m: m);
                },));

              }, icon: Icon(Icons.update),),
              IconButton(onPressed: () async {

                int id = m['id'];

                String qry = "delete from form where id = '$id'";
               await db!.rawDelete(qry);

               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                 return view_page();
               },));

              },icon: Icon(Icons.delete),),
              m['fav']=="0" ? IconButton(onPressed: () async {
                int id = m['id'];
                String qry ="update form set fav='1' where id = '$id'";
               await db!.rawUpdate(qry).then((value){
                 if(value==1)
                   {
                     getalldata();
                   }
               });



              }, icon: Icon(Icons.favorite_border),) : IconButton(onPressed: () async {

                int id = m['id'];
                String qry ="update form set fav='0' where id = '$id'";
                await db!.rawUpdate(qry).then((value) {
                  if(value==1)
                    {
                      getalldata();
                    }

                });


              }, icon: Icon(Icons.favorite),),
            ],
          ),

        );
      },
        separatorBuilder: (context, index) {
          return Container(height: 2,color: Colors.grey,);
        },

      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return insert_page(type: "insert");
        },));
      },child: Icon(Icons.add),),
    );
  }
}
