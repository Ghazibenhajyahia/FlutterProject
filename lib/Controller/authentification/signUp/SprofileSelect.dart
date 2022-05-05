import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Service/UserService.dart';
import '../../chooseCategory.dart';
import 'ComplexOwnerSignUp/CompleteComplexForm.dart';
import 'RefereeSignUp/CompleteRefereeForm.dart';
import 'package:shared_preferences/shared_preferences.dart';


  class RegisterProfileSelect extends StatefulWidget {
  const RegisterProfileSelect({Key? key, this.photo, required this.email, required this.name, required this.phone, required this.gender, required this.password, required this.birthDate}) : super(key: key);
  final XFile? photo;
  final String email;
  final String name;
  final String phone;
  final String gender;
  final String password;
  final String birthDate;

  @override
  _RegisterProfileSelectState createState() => _RegisterProfileSelectState();
}

class _RegisterProfileSelectState extends State<RegisterProfileSelect> {
  String type = "";
  bool isTrue = false;
  late String profilePic;
  late SharedPreferences prefs;
  Future<void> _continueBtnColor() async {
    setState(() {
      isTrue = true;
    });
  }

  bool  isPlayer = false;
  bool  isComplexOwner = false;
  bool  isReferee = false;

  Future<void> _ButtoncolorPlayer() async {
    setState(() {
      isPlayer=true;
      isComplexOwner=false;
      isReferee = false;
      type="player";
    });
  }
  Future<void> _ButtoncolorComplexOwner() async {
    setState(() {
      isPlayer=false;
      isComplexOwner=true;
      isReferee = false;
      type="complexeOwner";
    });
  }

  Future<void> _ButtoncolorReferee() async {
    setState(() {
      isPlayer=false;
      isComplexOwner=false;
      isReferee = true;
      type="arbitre";
    });
  }

  @override
  Widget build(BuildContext context) {

    var scrWidth = MediaQuery.of(context).size.width;
    bool isActive = false;

    bool Ff = true;


    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25,),
            LinearProgressIndicator(
              backgroundColor: Colors.white,
              value: 0.83,
              color: Color(0xff0962ff),
            ),
            Padding(padding:  EdgeInsets.fromLTRB(30, 50, 0, 0)
              ,child: Text(
                "Selecting",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.blue[800],
                    fontSize: 35,
                    fontFamily: 'Cardo'
                ),
              ),),
            Padding(padding:  EdgeInsets.fromLTRB(30, 10, 0, 0)
              ,child: Text(
                "my account type",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.blue[800],
                    fontSize: 35,
                    fontFamily: 'Cardo'
                ),
              ),),
            SizedBox(height: 100,),
            InkWell(
              child: Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 50),
                decoration: BoxDecoration(
                  border: Border.all(
                  ),
                  borderRadius: BorderRadius.circular(50),
                  color: isPlayer ? Color.fromRGBO(49, 39, 79, 1) : Colors.white,
                ),
                child: Center(
                  child: Text("Player", style: TextStyle(letterSpacing: 3,
                    color: isPlayer ? Colors.white : Color.fromRGBO(49, 39, 79, 1),
                  ),),
                ),
              ),
              onTap: (){
                _continueBtnColor();
                _ButtoncolorPlayer();
              },
            ),
            SizedBox(height: 18,),

            InkWell(
              child: Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 50),
                decoration: BoxDecoration(
                  border: Border.all(
                  ),
                  borderRadius: BorderRadius.circular(50),
                  color: isReferee ? Color.fromRGBO(49, 39, 79, 1) : Colors.white,
                ),
                child: Center(
                  child: Text("Referee", style: TextStyle(letterSpacing: 3,
                    color: isReferee ? Colors.white : Color.fromRGBO(49, 39, 79, 1),
                  ),),
                ),
              ),
              onTap: (){
                _continueBtnColor();
                _ButtoncolorReferee();
              },
            ),
            SizedBox(height: 18,),
            InkWell(
              onTap: () {
                _continueBtnColor();
                _ButtoncolorComplexOwner();
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 50),
                decoration: BoxDecoration(
                  border: Border.all(
                  ),
                  borderRadius: BorderRadius.circular(50),
                  color: isComplexOwner ?  Color.fromRGBO(49, 39, 79, 1) : Colors.white  ,
                ),
                child: Center(
                  child: Text("Complex Owner", style: TextStyle(
                      color: isComplexOwner ? Colors.white : Color.fromRGBO(49, 39, 79, 1)   ,
                      letterSpacing: 3
                  ),),
                ),
              ),
            ),


            SizedBox(height: 200,),
            Center(
              child: InkWell(
                onTap: ()async{
                  if(isPlayer== true){
                      var res = await UserService().CreateAccount(widget.name, widget.email , widget.password, widget.phone, widget.gender, type, widget.photo?.path,widget.birthDate,"player");
                    if(res == "duplicated"){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            title: Text("Information"),
                            content: Text("Email already existing"),
                          );
                        },
                      );
                    }else if (res == "error"){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            title: Text("Information"),
                            content: Text("Connexion problem !"),
                          );
                        },
                      );
                    }else {

                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseCategory()));
                    }
                    //
                  }
                  else if(isComplexOwner == true) {
                    var res = await UserService().CreateAccount(widget.name, widget.email , widget.password, widget.phone, widget.gender, type, widget.photo?.path,widget.birthDate,"complexe");
                    if(res == "duplicated"){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            title: Text("Information"),
                            content: Text("Email already existing"),
                          );
                        },
                      );
                    }else if (res == "error"){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            title: Text("Information"),
                            content: Text("Connexion problem !"),
                          );
                        },
                      );
                    }else{
                      print("hedha id complexeOwn : "+res!);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ComplexForm(id: res,)));
                    }
                  }
                  else if(isReferee== true){

                    var res = await UserService().CreateAccount(widget.name, widget.email , widget.password, widget.phone, widget.gender, type, widget.photo?.path,widget.birthDate,"referee");
                    if(res == "duplicated"){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            title: Text("Information"),
                            content: Text("Email already existing"),
                          );
                        },
                      );
                    }else if (res == "error"){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            title: Text("Information"),
                            content: Text("Connexion problem !"),
                          );
                        },
                      );
                    }else{
                      print("hedha id complexeOwn : "+res!);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RefereeForm(id: res,)));
                    }
                    }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  width: scrWidth * 0.80,
                  height: 65,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isTrue ? Color(0xff0962ff) : Colors.grey,
                    ),
                    color: isTrue ? Color(0xff0962ff) : Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isTrue ?  Colors.white : Colors.grey ,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}