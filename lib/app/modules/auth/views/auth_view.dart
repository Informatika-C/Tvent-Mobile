import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:tvent/app/routes/app_pages.dart';
import 'package:tvent/services/theme.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  AuthView({Key? key}) : super(key: key);
  final Name = TextEditingController(),
      Email = TextEditingController(),
      Npm = TextEditingController(),
      Phone = TextEditingController(),
      PassConfirm = TextEditingController(),
      Pass = TextEditingController();

  RxMap<String, String> hasFieldError = <String, String>{}.obs;

  RxBool rememberMe = false.obs,
      hidePass = true.obs,
      hidePassConfirm = true.obs,
      isLogin = true.obs;

  void clearTextController() {
    Name.clear();
    // Email.clear();
    Npm.clear();
    Phone.clear();
    Pass.clear();
    PassConfirm.clear();
  }

  @override
  Widget build(BuildContext context) {
    Widget Login = Container(
      width: MediaQuery.of(context).size.width - 50,
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/polygons.png"), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 3,
            offset: Offset(5, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "LOGIN",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  color: Colors.black,
                  child: Text("HI, WELCOME BACK",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Obx(
                  () => TextField(
                    onChanged: (controller) {
                      if (!Email.text
                          .toString()
                          .contains(RegExp(r"^[a-zA-Z0-9@\._]+$"))) {
                        hasFieldError['Email'] = "Invalid Email";
                      }else{
                        hasFieldError.remove('Email');
                      }
                    },
                    controller: Email,
                    decoration: InputDecoration(
                      label: (hasFieldError.containsKey('Email') &&
                              Email.text.isNotEmpty)
                          ? Text(hasFieldError['Email'].toString(),
                              style: TextStyle(color: Colors.red))
                          : Text("Email"),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: (hasFieldError.containsKey('Email') &&
                                    Email.text.isNotEmpty)
                                ? Colors.red
                                : Colors.black,
                          )),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: (hasFieldError.containsKey('Email') &&
                                  Email.text.isNotEmpty)
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(
                  () => TextField(
                    controller: Pass,
                    obscureText: hidePass.value,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: Text("Password"),
                      suffixIcon: InkWell(
                        onTap: () {
                          hidePass.value = !hidePass.value;
                          print(hidePass.value);
                        },
                        child: Icon(
                          (hidePass.value)
                              ? Icons.remove_red_eye_rounded
                              : Icons.remove_red_eye_outlined,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: rememberMe.value,
                        onChanged: (value) {
                          rememberMe.value = !rememberMe.value;
                        },
                      ),
                    ),
                    Text("Remember Me?"),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    if(hasFieldError.isEmpty){
                      AuthController().login(Email.text, Pass.text);
                    }else{
                      Get.defaultDialog(
                        title: "Login Failed",
                        middleText: "Make sure there is no error warning on the form",
                        confirm: TextButton(onPressed: () => Get.back(), child: Text("OK")),
                      );
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15, 7, 15, 7),
                    decoration: BoxDecoration(
                      color: Themes.light.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 2,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                          letterSpacing: 1,
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        isLogin.value = !isLogin.value;
                        clearTextController();
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
    Widget Register = Container(
      width: MediaQuery.of(context).size.width - 50,
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/polygons.png"), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 3,
            offset: Offset(5, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "REGISTER",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                TextField(
                    controller: Name,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(55),                      
                    ],
                    decoration: InputDecoration(
                      label: Text("Name"),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                SizedBox(
                  height: 10,
                ),
                Obx(
                  () => TextField(
                    onChanged: (controller) {
                      if (!Email.text
                          .toString()
                          .contains(RegExp(r"^[a-zA-Z0-9@\._]+$"))) {
                        hasFieldError['Email'] = "Invalid Email";
                      } else {
                        hasFieldError.remove('Email');
                      }
                    },
                    controller: Email,
                    decoration: InputDecoration(
                      label: (hasFieldError.containsKey('Email') &&
                              Email.text.isNotEmpty)
                          ? Text(hasFieldError['Email'].toString(),
                              style: TextStyle(color: Colors.red))
                          : Text("Email"),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: (hasFieldError.containsKey('Email') &&
                                    Email.text.isNotEmpty)
                                ? Colors.red
                                : Colors.black,
                          )),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: (hasFieldError.containsKey('Email') &&
                                  Email.text.isNotEmpty)
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                    onChanged: (controller) {
                      if (Npm.text.toString().length > 10) {
                        hasFieldError['Npm'] =
                            "Over Maximum npm ${Npm.text.toString().length} / 10";
                      } else {
                        hasFieldError.remove('Npm');
                      }
                    },
                    controller: Npm,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    decoration: InputDecoration(
                      label: Text("Npm"),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(13),
                  ],
                  controller: Phone,
                  decoration: InputDecoration(
                    label: Text("Phone"),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Obx(
                  () => TextField(
                    onChanged: (controller) {
                      if (Pass.text.toString().length < 6) {
                        hasFieldError['Pass'] =
                            "Password At Least 6 characters";
                      } else {
                        hasFieldError.remove('Pass');
                      }
                    },
                    controller: Pass,
                    obscureText: hidePass.value,
                    decoration: InputDecoration(
                      label: (hasFieldError.containsKey('Pass') &&
                              Pass.text.isNotEmpty)
                          ? Text(hasFieldError['Pass'].toString(),
                              style: TextStyle(color: Colors.red))
                          : Text("Pass"),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: (hasFieldError.containsKey('Pass') &&
                                    Pass.text.isNotEmpty)
                                ? Colors.red
                                : Colors.black,
                          )),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: (hasFieldError.containsKey('Pass') &&
                                  Pass.text.isNotEmpty)
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          hidePass.value = !hidePass.value;
                        },
                        child: Icon(
                          (hidePass.value)
                              ? Icons.remove_red_eye_rounded
                              : Icons.remove_red_eye_outlined,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Obx(
                  () => TextField(
                    onChanged: (controller) {
                      if (PassConfirm.text.toString() != Pass.text.toString()) {
                        hasFieldError['PassConfirm'] = "Password didn't match";
                      } else {
                        hasFieldError.remove('PassConfirm');
                      }
                    },
                    controller: PassConfirm,
                    obscureText: hidePassConfirm.value,
                    decoration: InputDecoration(
                      label: (hasFieldError.containsKey('PassConfirm') &&
                              PassConfirm.text.isNotEmpty)
                          ? Text(hasFieldError['PassConfirm'].toString(),
                              style: TextStyle(color: Colors.red))
                          : Text("PassConfirm"),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: (hasFieldError.containsKey('PassConfirm') &&
                                    PassConfirm.text.isNotEmpty)
                                ? Colors.red
                                : Colors.black,
                          )),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: (hasFieldError.containsKey('PassConfirm') &&
                                  PassConfirm.text.isNotEmpty)
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          hidePassConfirm.value = !hidePassConfirm.value;
                        },
                        child: Icon(
                          (hidePassConfirm.value)
                              ? Icons.remove_red_eye_rounded
                              : Icons.remove_red_eye_outlined,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    if(hasFieldError.isEmpty){
                      AuthController().register( Name.text, Email.text, Npm.text, Phone.text, Pass.text);
                    }else{
                      Get.defaultDialog(
                        title: "Registration Failed",
                        middleText: "Make sure there is no error warning on the form",
                        confirm: TextButton(onPressed: () => Get.back(), child: Text("OK")),
                      );
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15, 7, 15, 7),
                    decoration: BoxDecoration(
                      color: Themes.light.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 2,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                    child: Text(
                      "REGISTER",
                      style: TextStyle(
                          letterSpacing: 1,
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        isLogin.value = !isLogin.value;
                        clearTextController();
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
    return Scaffold(
      body: Obx(
        () => Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color.fromARGB(255, 238, 228, 207),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "TVENT",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: const Color.fromARGB(255, 195, 125, 125),
                            offset: const Offset(4.0, 4.0),
                            blurRadius: 0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (isLogin.value) Login else Register,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("2023 Const AlRight reserved"),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
