import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/auth/views/animate_tvent.dart';
import 'package:tvent/services/theme.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  AuthView({Key? key}) : super(key: key);

  final Name = TextEditingController();
  final Email = TextEditingController();
  final Npm = TextEditingController();
  final Phone = TextEditingController();
  final PassConfirm = TextEditingController();
  final Pass = TextEditingController();

  RxMap<String, String> hasFieldError = <String, String>{}.obs;
  RxBool rememberMe = false.obs;
  RxBool hidePass = true.obs;
  RxBool hidePassConfirm = true.obs;
  RxBool isLogin = true.obs;

  void clearTextController() {
    Name.clear();
    Email.clear();
    Npm.clear();
    Phone.clear();
    Pass.clear();
    PassConfirm.clear();
  }

  @override
  Widget build(BuildContext context) {
    Widget Login = Container(
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 2.0),
      width: double.infinity,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage("assets/images/polygons.png"),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
        borderRadius: BorderRadius.circular(40),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(0.25),
            offset: const Offset(3, 3),
            blurRadius: 4,
            spreadRadius: 4,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Login",
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50.0, bottom: 30.0),
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              "HI, WELCOME BACK",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.7,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    minLines: 1,
                    controller: Email,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10),
                      label: (hasFieldError.containsKey('Email') &&
                              Email.text.isNotEmpty)
                          ? Text(hasFieldError['Email'].toString(),
                              style: const TextStyle(color: Colors.red))
                          : const Text("Email"),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: (hasFieldError.containsKey('Email') &&
                                    Email.text.isNotEmpty)
                                ? Colors.red
                                : Colors.black,
                            width: 1.5,
                          )),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          color: (hasFieldError.containsKey('Email') &&
                                  Email.text.isNotEmpty)
                              ? Colors.red
                              : Colors.black,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Obx(
                  () => TextField(
                    controller: Pass,
                    obscureText: hidePass.value,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1.5,
                        ),
                      ),
                      label: const Text("Password"),
                      suffixIcon: InkWell(
                        onTap: () {
                          hidePass.value = !hidePass.value;
                          // print(hidePass.value);
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
                const SizedBox(height: 12),
                Container(
                  width: 180.0,
                  height: 30.0,
                  margin: const EdgeInsets.only(bottom: 15.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Obx(
                        () => Checkbox(
                          value: rememberMe.value,
                          onChanged: (value) {
                            rememberMe.value = !rememberMe.value;
                          },
                        ),
                      ),
                      const Text("Remember Me?"),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Obx(() {
            if (controller.isLoading.value) {
              return ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Themes.light.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 2.0,
                ),
                child: const SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              );
            } else {
              return ElevatedButton(
                onPressed: () async {
                  if (hasFieldError.isEmpty) {
                    try {
                      await controller.login(Email.text, Pass.text);
                    } catch (error) {
                      controller.isLoading.value = false;
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Themes.light.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  elevation: 7.0,
                ),
                child: const Text(
                  "LOGIN",
                  style: TextStyle(
                    letterSpacing: 1,
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              );
            }
          }),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
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
                child: const Text(
                  "Register",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    Widget Register = Container(
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 2.0),
      width: double.infinity,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage("assets/images/polygons.png"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(40),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0XFf000000).withOpacity(0.25),
            offset: const Offset(3, 3),
            blurRadius: 4,
            spreadRadius: 4,
          )
        ],
      ),
      child: Column(
        children: [
          const Text(
            "Register",
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50.0, bottom: 30.0),
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: Name,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(55),
                  ],
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),
                    label: const Text("Name"),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
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
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10),
                      label: (hasFieldError.containsKey('Email') &&
                              Email.text.isNotEmpty)
                          ? Text(hasFieldError['Email'].toString(),
                              style: const TextStyle(color: Colors.red))
                          : const Text("Email"),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: (hasFieldError.containsKey('Email') &&
                                    Email.text.isNotEmpty)
                                ? Colors.red
                                : Colors.black,
                            width: 1.5,
                          )),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          color: (hasFieldError.containsKey('Email') &&
                                  Email.text.isNotEmpty)
                              ? Colors.red
                              : Colors.grey,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
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
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),
                    label: const Text("Npm"),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(13),
                  ],
                  controller: Phone,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),
                    label: const Text("Phone"),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
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
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10),
                      label: (hasFieldError.containsKey('Pass') &&
                              Pass.text.isNotEmpty)
                          ? Text(hasFieldError['Pass'].toString(),
                              style: const TextStyle(color: Colors.red))
                          : const Text("Pass"),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: (hasFieldError.containsKey('Pass') &&
                                    Pass.text.isNotEmpty)
                                ? Colors.red
                                : Colors.black,
                            width: 1.5,
                          )),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          color: (hasFieldError.containsKey('Pass') &&
                                  Pass.text.isNotEmpty)
                              ? Colors.red
                              : Colors.grey,
                          width: 1.5,
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
                const SizedBox(height: 10),
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
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10),
                      label: (hasFieldError.containsKey('PassConfirm') &&
                              PassConfirm.text.isNotEmpty)
                          ? Text(hasFieldError['PassConfirm'].toString(),
                              style: const TextStyle(color: Colors.red))
                          : const Text("PassConfirm"),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: (hasFieldError.containsKey('PassConfirm') &&
                                    PassConfirm.text.isNotEmpty)
                                ? Colors.red
                                : Colors.black,
                            width: 1.5,
                          )),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          color: (hasFieldError.containsKey('PassConfirm') &&
                                  PassConfirm.text.isNotEmpty)
                              ? Colors.red
                              : Colors.grey,
                          width: 1.5,
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
              ],
            ),
          ),
          Obx(() {
            if (controller.isLoading.value) {
              return ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Themes.light.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 2.0,
                ),
                child: const SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              );
            } else {
              return ElevatedButton(
                onPressed: () async {
                  await controller.register(
                    Name.text,
                    Email.text,
                    Npm.text,
                    Phone.text,
                    Pass.text,
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Themes.light.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  elevation: 7.0,
                ),
                child: const Text(
                  "REGISTER",
                  style: TextStyle(
                    letterSpacing: 1,
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              );
            }
          }),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
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
                child: const Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0XFFE1DCD1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "TVENT",
          style: TextStyle(
            color: Color(0XFF1E2126),
            fontSize: 35,
            fontWeight: FontWeight.w800,
            shadows: [
              Shadow(
                color: Color(0xffBD83B8),
                offset: Offset(-4.0, 4.0),
                blurRadius: 0,
              ),
            ],
          ),
        ),
      ),
      body: Obx(
        () => Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: isLogin.value ? Login : Register,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 30.0,
            color: Colors.transparent,
          ),
          const Positioned(
            bottom: 10.0,
            child: Text(
              "©2023 CONST - AlRight reserved",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
