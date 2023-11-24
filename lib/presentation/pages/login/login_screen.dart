import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onanmedia_test/presentation/bloc/auth_bloc/auth_bloc.dart';

import 'package:onanmedia_test/widgets/custom_widget.dart';

import '../dashboard/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKeyLogin = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(24, 60, 24, 12),
                child: const Column(
                  children: [
                    Text(
                      "SISTEM INFORMASI AKADEMIK",
                      style: TextStyle(
                        color: Color(0xFF21ABA5),
                        fontSize: 19,
                        fontFamily: 'Public Sans',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                    Text(
                      'Universitas Developer',
                      style: TextStyle(
                        color: Color(0xFF2DBAB1),
                        fontSize: 17,
                        fontFamily: 'Public Sans',
                        fontWeight: FontWeight.w300,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).width / 2.5,
                width: MediaQuery.sizeOf(context).width / 2.5,
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.fill,
                ),
              ),
              const Text(
                'Login',
                style: TextStyle(
                  color: Color(0xFF2DBAB1),
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              // mulai
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is LoadingLogin) {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 120),
                            child: Dialog(
                              insetPadding: EdgeInsets.zero,
                              clipBehavior: Clip.antiAliasWithSaveLayer,

                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8.0)), //this right here
                              child: Container(
                                height: MediaQuery.of(context).size.height / 8,
                                width: MediaQuery.of(context).size.width / 4,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator.adaptive(),
                                    SizedBox(height: 15),
                                    Text('Loading...'),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                    // SizedBox(
                    //   width: MediaQuery.sizeOf(context).width / 2,
                    //   height: MediaQuery.sizeOf(context).width / 3,
                    //   child: const Center(
                    //       child: CircularProgressIndicator.adaptive()),
                    // );
                  }

                  if (state is FailureLogin) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.white,
                            ),
                            width: MediaQuery.sizeOf(context).width / 2,
                            height: MediaQuery.sizeOf(context).width / 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(state.messageError),
                                const SizedBox(height: 8),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF2DBAB1)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("OK"),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }

                  if (state is SuccessLogin) {
                    Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DashboardScreen(userProfile: state.result),
                        ),
                        (route) => false);
                  }
                },
                builder: (context, state) {
                  return FormLoginWidget(
                      formKeyLogin: _formKeyLogin,
                      emailController: emailController,
                      passwordController: passwordController);
                },
              ),
            ],
          ),
        ),
      ),
    );
    // Scaffold(
    //   body: Container(
    //     // width: 414,
    //     // height: 896,
    //     clipBehavior: Clip.antiAlias,
    //     decoration: ShapeDecoration(
    //       color: Colors.white,
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(30),
    //       ),
    //       shadows: [
    //         BoxShadow(
    //           color: Color(0x3F000000),
    //           blurRadius: 32,
    //           offset: Offset(0, 0),
    //           spreadRadius: -2,
    //         )
    //       ],
    //     ),
    //     child: Stack(
    //       children: [
    //         Positioned(
    //           left: 89,
    //           top: 125,
    //           child: Container(
    //             width: 236,
    //             height: 254,
    //             decoration: BoxDecoration(
    //               image: DecorationImage(
    //                 image: NetworkImage("https://via.placeholder.com/236x254"),
    //                 fit: BoxFit.fill,
    //               ),
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           left: 173,
    //           top: 377,
    //           child: Text(
    //             'Login',
    //             style: TextStyle(
    //               color: Color(0xFF007B73),
    //               fontSize: 27,
    //               fontFamily: 'Righteous',
    //               fontWeight: FontWeight.w400,
    //               height: 0,
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           left: 59,
    //           top: 63,
    //           child: Text(
    //             'SISTEM INFORMASI AKADEMIK',
    //             style: TextStyle(
    //               color: Color(0xFF21ABA5),
    //               fontSize: 19,
    //               fontFamily: 'Public Sans',
    //               fontWeight: FontWeight.w700,
    //               height: 0,
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           left: 122,
    //           top: 90,
    //           child: Text(
    //             'Universitas Developer',
    //             style: TextStyle(
    //               color: Color(0xFF2DBAB1),
    //               fontSize: 17,
    //               fontFamily: 'Public Sans',
    //               fontWeight: FontWeight.w300,
    //               height: 0,
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           left: 143,
    //           top: 677,
    //           child: Text(
    //             'Lupa Password?',
    //             style: TextStyle(
    //               color: Color(0xFF2DBAB1),
    //               fontSize: 17,
    //               fontFamily: 'Public Sans',
    //               fontWeight: FontWeight.w300,
    //               height: 0,
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           left: 33,
    //           top: 435,
    //           child: Container(
    //             width: 350,
    //             height: 67,
    //             child: Stack(
    //               children: [
    //                 Positioned(
    //                   left: 0,
    //                   top: 0,
    //                   child: Container(
    //                     width: 350,
    //                     height: 67,
    //                     decoration: ShapeDecoration(
    //                       color: Color(0xFFFAF9F9),
    //                       shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(35),
    //                       ),
    //                       shadows: [
    //                         BoxShadow(
    //                           color: Color(0x3F000000),
    //                           blurRadius: 2,
    //                           offset: Offset(0, 0),
    //                           spreadRadius: 0,
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   left: 73,
    //                   top: 22,
    //                   child: Text(
    //                     'Nomor Mahasiswa',
    //                     style: TextStyle(
    //                       color: Color(0xFFD1D1D1),
    //                       fontSize: 18,
    //                       fontFamily: 'Public Sans',
    //                       fontWeight: FontWeight.w600,
    //                       height: 0,
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           left: 32,
    //           top: 513,
    //           child: Container(
    //             width: 350,
    //             height: 67,
    //             child: Stack(
    //               children: [
    //                 Positioned(
    //                   left: 0,
    //                   top: 0,
    //                   child: Container(
    //                     width: 350,
    //                     height: 67,
    //                     decoration: ShapeDecoration(
    //                       color: Color(0xFFFAF9F9),
    //                       shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(30),
    //                       ),
    //                       shadows: [
    //                         BoxShadow(
    //                           color: Color(0x3F000000),
    //                           blurRadius: 2,
    //                           offset: Offset(0, 0),
    //                           spreadRadius: 0,
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned(
    //                   left: 73,
    //                   top: 22,
    //                   child: Text(
    //                     'Password',
    //                     style: TextStyle(
    //                       color: Color(0xFFD1D1D1),
    //                       fontSize: 18,
    //                       fontFamily: 'Public Sans',
    //                       fontWeight: FontWeight.w600,
    //                       height: 0,
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           left: 33,
    //           top: 596,
    //           child: Container(
    //             width: 349,
    //             height: 64,
    //             decoration: ShapeDecoration(
    //               color: Color(0xFF2DBAB1),
    //               shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(30),
    //               ),
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           left: 179,
    //           top: 612,
    //           child: Text(
    //             'Login',
    //             style: TextStyle(
    //               color: Colors.white,
    //               fontSize: 22,
    //               fontFamily: 'Righteous',
    //               fontWeight: FontWeight.w400,
    //               height: 0,
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           left: 141,
    //           top: 855,
    //           child: Stack(
    //             children: [
    //               Positioned(
    //                 left: 19,
    //                 top: 0,
    //                 child: Text(
    //                   'Hubungi Admin',
    //                   style: TextStyle(
    //                     color: Color(0xFF2DBAB1),
    //                     fontSize: 15,
    //                     fontFamily: 'Public Sans',
    //                     fontWeight: FontWeight.w600,
    //                     height: 0,
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

class FormLoginWidget extends StatelessWidget {
  const FormLoginWidget({
    super.key,
    required GlobalKey<FormState> formKeyLogin,
    required this.emailController,
    required this.passwordController,
  }) : _formKeyLogin = formKeyLogin;

  final GlobalKey<FormState> _formKeyLogin;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Form(
        key: _formKeyLogin,
        child: Column(
          children: <Widget>[
            CustomTextFormFieldWidget(
              iconData: Icons.email,
              textFieldController: emailController,
              typeTextField: TypeTextField.email,
              hintText: "Ketik Email Anda",
            ),
            CustomTextFormFieldWidget(
              iconData: Icons.lock,
              textFieldController: passwordController,
              typeTextField: TypeTextField.password,
              hintText: "Ketik Kata Sandi / Password",
            ),

            const SizedBox(height: 30),
            SizedBox(
              height: MediaQuery.of(context).size.width / 7,
              width: MediaQuery.of(context).size.width / 1.2,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  shadowColor: Colors.black,
                  backgroundColor: Color(0xFF21ABA5),
                  // backgroundColor: (buttonName.name == ButtonName.mainButton.name)
                  //     ? mainGreen
                  //     : mainWhite,
                  // (customColor != null)
                  //     ? customColor
                  //     : ((buttonName.name == ButtonName.login.name))
                  //         ? mainGreen
                  //         : mainWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: () async {
                  // BlocProvider.of<AuthBloc>(context).add(
                  //   LoginEvent(
                  //     email: emailController.text,
                  //     password: passwordController.text,
                  //   ),
                  BlocProvider.of<AuthBloc>(context).add(
                    LoginEvent(
                      email: "indrat.saputra@mail.com",
                      password: "123123",
                    ),
                  );

                  // // SignInSignUpResult result =
                  // var result = await AuthServices.signInWithEmail(
                  //   email: emailController.text,
                  //   pass: passwordController.text,
                  // );

                  // print(
                  //     ">>>result  : ${result.user} - ${result.message}");

                  // Navigator.pushAndRemoveUntil(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => DashboardScreen(),
                  //     ),
                  //     (route) => false);
                },
                // () {
                //   (buttonName.name == ButtonName.mainButton.name)
                //       ? Navigator.pushNamed(context, AppRoutes.login)
                //       : Navigator.pushNamed(context, AppRoutes.register);
                // },
                child: const Text(
                  // (buttonName.name == ButtonName.login.name) ? "LOGIN" : "DAFTAR",
                  "Login",
                  style: TextStyle(
                    fontSize: 22,
                    // color: (buttonName.name == ButtonName.mainButton.name)
                    //     ? mainWhite
                    //     : mainGreen,
                  ),
                ),
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.only(top: 30),
            //   child: Text("Atau lanjutkan dengan"),
            // ),
            // const SizedBox(height: 30),
            // Container(
            //   decoration: BoxDecoration(
            //     border: Border.all(color: Colors.white, width: 2),
            //     shape: BoxShape.rectangle,
            //   ),
            //   child: IconButton(
            //     onPressed: () {},
            //     icon: Image.asset(googleLogo),
            //   ),
            // ),
            // const SizedBox(height: 50),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: <Widget>[
            //     const Text("Belum menjadi anggota?"),
            //     TextButton(
            //         onPressed: () {
            //           // Navigator.pushNamed(
            //           //     context, AppRoutes.register);
            //         },
            //         child: const Text("Daftar sekarang")),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
