import 'package:flutter/material.dart';
import 'package:loginpagedatabase/data.dart';
import 'package:loginpagedatabase/view_page.dart';
// import 'package:login_id/data.dart';
// import 'package:login_id/view_page.dart';
import 'package:sqflite/sqflite.dart';

class insert_page extends StatefulWidget {

  String? type;
  Map? m;

  insert_page({required this.type,this.m});

  @override
  State<insert_page> createState() => _insert_pageState();
}

class _insert_pageState extends State<insert_page> {
  TextEditingController tname = TextEditingController();
  TextEditingController tnumber = TextEditingController();
  TextEditingController temail = TextEditingController();
  TextEditingController tpassword = TextEditingController();
  TextEditingController retpassword = TextEditingController();
  Database? db;

  bool namestatus = false;
  bool numberstatus =false;
  bool emailstatus = false;
  bool passwordstatus = false;
  bool repasswordstatus = false;

  String numbermsg ="";
  String emailmsg ="";
  String passwordmsg ="";
  String repasswordmsg = "";

  bool hidepassword =true;
  bool rehidepassword =true;

  bool emailvalid=false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fillDataForUpdate();

    data().createDatabase().then((value) {
      db=value;
    });

  }

  fillDataForUpdate()
  {
    if(widget.type=="update")
      {
        tname.text= widget.m!['name'];
        tnumber.text= widget.m!['number'];
        temail.text= widget.m!['email'];
        tpassword.text= widget.m!['password'];
        retpassword.text= widget.m!['repassword'];
      }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      appBar: AppBar(),
      body: Container(
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            TextField(
              controller: tname,
              decoration: InputDecoration(
                errorText: namestatus ? "Please Enter name" : null,
                errorBorder: OutlineInputBorder(),

                border: OutlineInputBorder(),
                label: Text("Enter Name"),
                prefixIcon: Icon(Icons.create_outlined,),



              ),
            ),
            TextField(

              maxLength: 10,
              controller: tnumber,
              decoration: InputDecoration(
                errorText: numberstatus ? numbermsg : null,
                errorBorder: OutlineInputBorder(),
                border: OutlineInputBorder(),
                label: Text("Enter Number"),
                prefixIcon: Icon(Icons.phone_outlined,),
                prefix: Text("+91"),




              ),
            ),
            TextField(

              controller: temail,
              decoration: InputDecoration(

                  border: OutlineInputBorder(),
                  label: Text("Enter Email"),
                  errorText: emailstatus ? emailmsg : null,
                  errorBorder: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email_outlined,),
                  hintText: "abc@gmail.com"

              ),
            ),

            TextField(

              controller: tpassword,
              obscureText: hidepassword,
              enabled: widget.type=="update"? false : true,
              // textInputAction: widget.type=="update"?TextInputAction.none:TextInputAction.done,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: IconButton(onPressed: () {
                  hidepassword =!hidepassword;
                  setState(() {});


                },icon: hidepassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off)),
                label: Text("Enter Password"),
                errorText: passwordstatus ? "not valid" : null,
                errorBorder: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock_outlined,),


              ),
            ),
            TextField(

              controller: retpassword,
              obscureText: rehidepassword,
              enabled: widget.type=="update"? false : true,
              // textInputAction: widget.type=="update"?TextInputAction.none:TextInputAction.done,
              decoration: InputDecoration(
                border: OutlineInputBorder(

                ),
                suffixIcon: IconButton(onPressed: () {
                  rehidepassword =!rehidepassword;
                  setState(() {});


                },icon: rehidepassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off)),
                label: Text("Re Enter Password"),
                errorText: repasswordstatus ? "Password must be same as above" : null,
                errorBorder: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock_outlined,),


              ),
            ),
            ElevatedButton(onPressed: () async {

              namestatus = false;
              numberstatus =false;
              emailstatus = false;
              passwordstatus = false;
              repasswordstatus =false;

              String name = tname.text;
              String number = tnumber.text;
              String email = temail.text;


              bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);

              String password = tpassword.text;
              String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
              RegExp regExp  = RegExp(pattern);
              bool validpassword = regExp.hasMatch(password);

              String repassword = retpassword.text;
              String  repattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
              RegExp reregExp  = RegExp(repattern);
              bool revalidpassword = reregExp.hasMatch(repassword);
              if(name.isEmpty)
              {
                namestatus=true;
                setState(() {});

              }
              else if(number.isEmpty)
              {
                numberstatus=true;
                setState(() {});
              }
              else if(number.length<10)
              {
                numberstatus=true;
                numbermsg="Please Enter Valid Number";
                setState(() {});


              }
              else if(email.isEmpty)
              {
                emailstatus = true;
                emailmsg="Please Enter Email";
                setState(() {});

              }
              else if (!emailValid)
              {
                emailstatus=true;
                emailmsg="Please Enter valid Email";
                setState(() {});


              }
              else if(password.isEmpty)
              {
                passwordstatus=true;
                passwordmsg = "Please Enter password";
                setState(() {});

              }
              else if(!validpassword)
              {
                passwordstatus=true;
                passwordmsg = "Password is not valid";
                setState(() {});

              }
              else if(repassword.isEmpty)
              {
                repasswordstatus=true;
                passwordmsg = "Please Re Enter password";
                setState(() {});

              }
              else if(!revalidpassword)
                {
                  repasswordstatus=true;
                  setState(() {});
                }
              else if(repassword!=password)
              {
                repasswordstatus=true;
                setState(() {});
              }
              else
              {
                if(widget.type=="insert")
                {
                  String qry ="insert into form (name, number , email ,password,repassword, fav) values ('$name','$number','$email','$password','$repassword', '0')";
                  int a = await db!.rawInsert(qry);
                  print(a);

                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return view_page();
                  },));
                }
                else
                {
                  int id = widget.m!['id'];
                  String qry ="update form set name= '$name', number = '$number', email = '$email' where id = '$id'";
                  int a = await db!.rawUpdate(qry);
                  print(a);

                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return view_page();
                  },));
                }

              }

            }, child: widget.type=="insert" ? Text("Login") : Text("update"))
          ],
        ),
      ),
    ), onWillPop: goBack);
  }


  Future<bool> goBack()
  {

    // Navigator.pop(context);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return view_page();
    },));
    return Future.value();
  }
}
