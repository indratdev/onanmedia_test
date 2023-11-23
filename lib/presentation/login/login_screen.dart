import 'package:flutter/material.dart';
import 'package:onanmedia_test/presentation/dashboard/dashboard_screen.dart';
import 'package:onanmedia_test/widgets/custom_widget.dart';

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
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(24, 60, 24, 12),
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
                width: MediaQuery.sizeOf(context).width / 2,
                height: MediaQuery.sizeOf(context).width / 2,
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                'Login',
                style: TextStyle(
                  color: Color(0xFF2DBAB1),
                  fontSize: 27,
                  fontFamily: 'Righteous',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              // mulai
              Padding(
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
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DashboardScreen(),
                                ),
                                (route) => false);
                          },
                          // () {
                          //   (buttonName.name == ButtonName.mainButton.name)
                          //       ? Navigator.pushNamed(context, AppRoutes.login)
                          //       : Navigator.pushNamed(context, AppRoutes.register);
                          // },
                          child: Text(
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
