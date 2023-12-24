import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tvent/services/theme.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  AuthView({Key? key}) : super(key: key);

  final name = TextEditingController();
  final email = TextEditingController();
  final npm = TextEditingController();
  final phone = TextEditingController();
  final passConfirm = TextEditingController();
  final pass = TextEditingController();

  final RxMap<String, String> hasFieldError = <String, String>{}.obs;
  final RxBool rememberMe = false.obs;
  final RxBool hidePass = true.obs;
  final RxBool hidePassConfirm = true.obs;
  final RxBool isLogin = true.obs;

  void clearTextController() {
    name.clear();
    email.clear();
    npm.clear();
    phone.clear();
    pass.clear();
    passConfirm.clear();
  }

  @override
  Widget build(BuildContext context) {
    Widget login = Container(
      width: MediaQuery.of(context).size.width / 2,
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 2.0),
      // width: double.infinity,
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
            style: TextStyle(
                color: Colors.black, fontSize: 35, fontWeight: FontWeight.w900),
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
                    cursorColor: Colors.black,
                    style: const TextStyle(color: Colors.black),
                    onChanged: (controller) {
                      if (!email.text
                          .toString()
                          .contains(RegExp(r"^[a-zA-Z0-9@\._]+$"))) {
                        hasFieldError['Email'] = "Invalid Email";
                      } else {
                        hasFieldError.remove('Email');
                      }
                    },
                    minLines: 1,
                    controller: email,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10),
                      label: (hasFieldError.containsKey('Email') &&
                              email.text.isNotEmpty)
                          ? Text(hasFieldError['Email'].toString(),
                              style: const TextStyle(color: Colors.red))
                          : const Text("Email",
                              style: TextStyle(color: Colors.black)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: (hasFieldError.containsKey('Email') &&
                                    email.text.isNotEmpty)
                                ? Colors.red
                                : Colors.black,
                            width: 1.5,
                          )),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          color: (hasFieldError.containsKey('Email') &&
                                  email.text.isNotEmpty)
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
                    cursorColor: Colors.black,
                    style: const TextStyle(color: Colors.black),
                    controller: pass,
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
                      label: const Text("Password",
                          style: TextStyle(color: Colors.black)),
                      suffixIcon: InkWell(
                        onTap: () {
                          hidePass.value = !hidePass.value;
                          // print(hidePass.value);
                        },
                        child: Icon(
                          (hidePass.value)
                              ? FontAwesomeIcons.eyeLowVision
                              : FontAwesomeIcons.eye,
                          color: Colors.grey,
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
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return Theme.of(context)
                                  .colorScheme
                                  .surfaceVariant;
                            }
                            return Colors.green.withOpacity(0.8);
                          }),
                        ),
                      ),
                      const Text(
                        "Remember Me?",
                        style: TextStyle(color: Colors.black),
                      ),
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
                  backgroundColor: Themes.light.primaryColor,
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
                      await controller.login(email.text, pass.text);
                    } catch (error) {
                      controller.isLoading.value = false;
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Themes.light.primaryColor,
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
                style: TextStyle(fontSize: 12, color: Colors.black),
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
    Widget register = Container(
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
            style: TextStyle(
                color: Colors.black, fontSize: 35, fontWeight: FontWeight.w900),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50.0, bottom: 30.0),
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),
                  controller: name,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(55),
                  ],
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),
                    label: const Text("Name",
                        style: TextStyle(color: Colors.black)),
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
                    cursorColor: Colors.black,
                    style: const TextStyle(color: Colors.black),
                    onChanged: (controller) {
                      if (!email.text
                          .toString()
                          .contains(RegExp(r"^[a-zA-Z0-9@\._]+$"))) {
                        hasFieldError['Email'] = "Invalid Email";
                      } else {
                        hasFieldError.remove('Email');
                      }
                    },
                    controller: email,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10),
                      label: (hasFieldError.containsKey('Email') &&
                              email.text.isNotEmpty)
                          ? Text(hasFieldError['Email'].toString(),
                              style: const TextStyle(color: Colors.red))
                          : const Text("Email",
                              style: TextStyle(color: Colors.black)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: (hasFieldError.containsKey('Email') &&
                                    email.text.isNotEmpty)
                                ? Colors.red
                                : Colors.black,
                            width: 1.5,
                          )),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          color: (hasFieldError.containsKey('Email') &&
                                  email.text.isNotEmpty)
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
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),
                  onChanged: (controller) {
                    if (npm.text.toString().length > 10) {
                      hasFieldError['Npm'] =
                          "Over Maximum npm ${npm.text.toString().length} / 10";
                    } else {
                      hasFieldError.remove('Npm');
                    }
                  },
                  controller: npm,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),
                    label: const Text("Npm",
                        style: TextStyle(color: Colors.black)),
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
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(13),
                  ],
                  controller: phone,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),
                    label: const Text("Phone",
                        style: TextStyle(color: Colors.black)),
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
                    cursorColor: Colors.black,
                    style: const TextStyle(color: Colors.black),
                    onChanged: (controller) {
                      if (pass.text.toString().length < 6) {
                        hasFieldError['Pass'] =
                            "Password At Least 6 characters";
                      } else {
                        hasFieldError.remove('Pass');
                      }
                    },
                    controller: pass,
                    obscureText: hidePass.value,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10),
                      label: (hasFieldError.containsKey('Pass') &&
                              pass.text.isNotEmpty)
                          ? Text(hasFieldError['Pass'].toString(),
                              style: const TextStyle(color: Colors.red))
                          : const Text("Pass",
                              style: TextStyle(color: Colors.black)),
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
                                    pass.text.isNotEmpty)
                                ? Colors.red
                                : Colors.black,
                            width: 1.5,
                          )),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          color: (hasFieldError.containsKey('Pass') &&
                                  pass.text.isNotEmpty)
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
                              ? FontAwesomeIcons.eyeLowVision
                              : FontAwesomeIcons.eye,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => TextField(
                    cursorColor: Colors.black,
                    style: const TextStyle(color: Colors.black),
                    onChanged: (controller) {
                      if (passConfirm.text.toString() !=
                          passConfirm.text.toString()) {
                        hasFieldError['PassConfirm'] = "Password didn't match";
                      } else {
                        hasFieldError.remove('PassConfirm');
                      }
                    },
                    controller: passConfirm,
                    obscureText: hidePassConfirm.value,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10),
                      label: (hasFieldError.containsKey('PassConfirm') &&
                              passConfirm.text.isNotEmpty)
                          ? Text(hasFieldError['PassConfirm'].toString(),
                              style: const TextStyle(color: Colors.red))
                          : const Text("PassConfirm",
                              style: TextStyle(color: Colors.black)),
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
                                    passConfirm.text.isNotEmpty)
                                ? Colors.red
                                : Colors.black,
                            width: 1.5,
                          )),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          color: (hasFieldError.containsKey('PassConfirm') &&
                                  passConfirm.text.isNotEmpty)
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
                              ? FontAwesomeIcons.eyeLowVision
                              : FontAwesomeIcons.eye,
                          color: Colors.grey,
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
                  backgroundColor: Themes.light.primaryColor,
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
                    name.text,
                    email.text,
                    npm.text,
                    phone.text,
                    pass.text,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Themes.light.primaryColor,
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
                style: TextStyle(fontSize: 12, color: Colors.black),
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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "TVENT",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 45,
            fontWeight: FontWeight.w800,
            shadows: [
              Shadow(
                color: Theme.of(context).colorScheme.surfaceVariant,
                offset: const Offset(-4.0, 4.0),
                blurRadius: 0,
              ),
            ],
          ),
        ),
      ),
      body: Obx(
        () => Center(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 26.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                isLogin.value ? login : register,
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
