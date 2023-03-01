import 'package:exchange/models/user_model.dart';
import 'package:exchange/network/response_model.dart';
import 'package:exchange/providers/user_data_provider.dart';
import 'package:exchange/ui/main_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SingupScreen extends StatefulWidget {
  const SingupScreen({super.key});

  @override
  State<SingupScreen> createState() => _SingupScreenState();
}

class _SingupScreenState extends State<SingupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  late UserDataProvider userProvider;

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var textTheme = Theme.of(context).textTheme;
    var cardColor = Theme.of(context).cardColor;
    userProvider = Provider.of<UserDataProvider>(context);

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Lottie.asset('assets/images/waveloop.json',
                height: height * 0.2, width: width, fit: BoxFit.fill),
            SizedBox(height: height * 0.05),
            Padding(
              padding: EdgeInsets.only(left: width / 20),
              child: Text(
                'Sing Up',
                style: GoogleFonts.ubuntu(
                    fontSize: height * 0.035,
                    color: Theme.of(context).unselectedWidgetColor),
              ),
            ),
            SizedBox(height: height * 0.01),
            Padding(
              padding: EdgeInsets.only(left: width / 20),
              child: Text(
                'Create Account',
                style: GoogleFonts.ubuntu(
                    fontSize: height * 0.03,
                    color: Theme.of(context).unselectedWidgetColor),
              ),
            ),
            SizedBox(height: height * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: cardColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: cardColor),
                        ),
                        prefixIcon: Icon(Icons.person, color: cardColor),
                        hintText: 'Username',
                        hintStyle: textTheme.bodySmall,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter username';
                        } else if (value.length < 4) {
                          return 'at least enter 4 charecters';
                        } else if (value.length >= 20) {
                          return ('maximum charecter is 20');
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    TextFormField(
                      controller: passwordController,
                      obscureText: isObscure,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: cardColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: cardColor),
                        ),
                        prefixIcon: Icon(Icons.lock_open, color: cardColor),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isObscure ? Icons.visibility : Icons.visibility_off,
                            color: cardColor,
                          ),
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                        ),
                        hintText: 'Password',
                        hintStyle: textTheme.bodySmall,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter passwoed';
                        } else if (value.length < 6) {
                          return 'at least enter 6 charecters';
                        } else if (value.length >= 17) {
                          return ('maximum charecter is 17');
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.22),
                    Consumer<UserDataProvider>(
                      builder: (context, userDataProvider, child) {
                        switch (userDataProvider.registerStatus?.status) {
                          case Status.LOADING:
                            return LoadingAnimationWidget.inkDrop(
                              color: Color(0xff4a64fe),
                              size: 35,
                            );
                          case Status.COMPLETED:
                            savedLogin(userDataProvider.registerStatus?.data);
                            WidgetsBinding.instance.addPostFrameCallback(
                              (timeStamp) => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MainWrapper(),
                                ),
                              ),
                            );
                            return signupBtn();
                          case Status.ERROR:
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                signupBtn(),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.error,
                                      color: Colors.redAccent,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      userDataProvider.registerStatus!.message,
                                      style: GoogleFonts.ubuntu(
                                          color: Colors.redAccent,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          default:
                            return signupBtn();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                'Creating an account means you\'re okay with our Terms of Services and our our Privacy Polity',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget signupBtn() {
    var primaryColor = Theme.of(context).primaryColor;

    var height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: double.infinity,
      height: height / 14,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        onPressed: () {
          // Validate returns true if the form is valid, or false otherwise.
          if (_formKey.currentState!.validate()) {
            userProvider.callRegisterApi(
                nameController.text, passwordController.text);
          }
        },
        child: const Text('Sign Up'),
      ),
    );
  }

  void savedLogin(UserModel model) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('user_token', model.token!);
    prefs.setBool('loggesIn', true);
  }
}
