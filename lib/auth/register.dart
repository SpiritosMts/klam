
import 'package:klam/models/user.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../bindings.dart';
import '../firebaseVoids.dart';
import '../myUi.dart';
import '../myVoids.dart';
import 'package:uuid/uuid.dart';

import '../styles.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  bool _isPwdObscure = true;
  String newUserRole = Get.arguments['newUserRole'];

  final nameTec = TextEditingController();
  final emailTec = TextEditingController();
  final passwordTec = TextEditingController();
  final phoneTec = TextEditingController();
  final addressTec = TextEditingController();

  TextEditingController cityTextController = TextEditingController();//
  TextEditingController instituteTextController = TextEditingController();//
  TextEditingController subjectTextController = TextEditingController();//
  TextEditingController classNameTextController = TextEditingController();//




  GlobalKey<FormState> _registerFormkey = GlobalKey<FormState>();

  double spaceFields= 25;



  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 400), () {
      //streamingDoc(usersColl,authCtr.cUser.id!);
    });

  }


  addNewUser() async {
     String  userEmail = emailTec.text;

    ScUser newUser= ScUser(
        name: nameTec.text,
        email: emailTec.text,
        pwd: passwordTec.text,
        phone:phoneTec.text ,
        city:cityTextController.text ,
        className:classNameTextController.text ,
        institute: instituteTextController.text,
        subject: subjectTextController.text,
      role: newUserRole,
        joinTime: todayToString(showHoursNminutes: true),
    );

    Future<void> addUserDoc() async {
      try{
        String specificID = Uuid().v1();

        var value = await addDocument(
          specificID: specificID,
          fieldsMap: newUser.toJson(),
          coll: usersColl,

        );
        Get.back(); //hide loading
        Future.delayed(const Duration(milliseconds: 3000), () async {
          await authCtr.getUserInfoByEmail(userEmail);
          goHome();
        });
      }catch  (err){
        print('## cant create user account : $err');
      }
    }


    if (_registerFormkey.currentState!.validate()) {
      showLoading(text: 'Connecting');

      authCtr.signUp(userEmail, passwordTec.text, onSignUp: () {
        addUserDoc();
      });

    }
  }




  // /////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: backGroundTemplate(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Form(
            key: _registerFormkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  Container(
                    child:  Text(
                      'Register',
                      style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 35,
                          color: registerTitleColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    child: Text(
                      newUserRole,
                      style: const TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 30,
                          color: registerSubtitleColor,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(height: 40,),

                  /// /////////////////////////////////

                  // business name
                  customTextField(
                    controller: nameTec,
                    labelText: 'Name',
                    //hintText: 'Enter your business name',
                    icon: Icons.person,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "name can't be empty";
                      }
                     else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: spaceFields),

                  //email
                  customTextField(
                    controller: emailTec,
                    labelText: 'Email',
                    //hintText: 'Enter your email',
                    icon: Icons.email,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "email can't be empty";
                      }
                      if (!EmailValidator.validate(value)) {
                        return ("Enter a valid email");
                      } else {
                        return null;
                      }
                    },
                  ),
                    SizedBox(height: spaceFields),

                    // ggl reg dont need pwd
                    customTextField(
                      controller: passwordTec,
                      labelText: 'Password',
                      //hintText: 'Enter your password',
                      icon: Icons.lock,
                      isPwd: true,
                      obscure: _isPwdObscure,
                      onSuffClick: (){
                        setState(() {
                          _isPwdObscure = !_isPwdObscure;
                        });
                      },
                      validator: (value) {
                        RegExp regex = RegExp(r'^.{6,}$');
                        if (value!.isEmpty) {
                          return "password can't be empty";
                        }
                        if (!regex.hasMatch(value)) {
                          return ('Enter a valid password of at least 6 characters');
                        } else {
                          return null;
                        }
                      },
                    ),


                  SizedBox(height: spaceFields),
                  customTextField(//phone
                    textInputType: TextInputType.number,

                    controller: phoneTec,
                    labelText: 'Phone',
                    //hintText: 'Enter your number',
                    icon: Icons.phone,
                    isPwd: false,
                    obscure: false,
                    onSuffClick: (){},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "number can't be empty";
                      }
                      else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: spaceFields),

                  customTextField(//address
                    controller: cityTextController,
                    labelText: 'City',
                    //hintText: 'Enter your address',
                    icon: Icons.location_city,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "city can't be empty";
                      }
                     else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: spaceFields),

                  customTextField(//address
                    controller: instituteTextController,
                    labelText: 'Institute',
                    //hintText: 'Enter your address',
                    icon: Icons.home_work_outlined,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "institute can't be empty";
                      }
                     else {
                        return null;
                      }
                    },
                  ),

                  SizedBox(height: spaceFields),

                  newUserRole == authCtr.roles[1]? customTextField(//address
                    controller: subjectTextController,
                    labelText: 'Institute',
                    //hintText: 'Enter your address',
                    icon: Icons.school,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "subject can't be empty";
                      }
                     else {
                        return null;
                      }
                    },
                  ):customTextField(//address
                    controller: classNameTextController,
                    labelText: 'Class',
                    //hintText: 'Enter your address',
                    icon: Icons.school,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "class can't be empty";
                      }
                      else {
                        return null;
                      }
                    },
                  ),

                  SizedBox(height: spaceFields),


                  /// ----------  Button signUp --------------------
                  Container(
                    //color: Colors.red,
                    width: 90.w,
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: registerBtnCol,
                        shadowColor: Color(0x2800000),
                        elevation: 0.1,
                        side: const BorderSide(width: 1.5, color: registerBtnBorderCol),
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        addNewUser();
                      },
                      child:  Text(
                        "Create account",
                        style: TextStyle(
                            fontSize: 16,
                            color: btnTextCol,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

}
