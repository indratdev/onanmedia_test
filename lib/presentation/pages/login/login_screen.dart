import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onanmedia_test/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:onanmedia_test/presentation/pages/login/widgets/form_login_widget.dart';

import '../../../shared/utils/global_variables.dart';
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
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                child: Column(
                  children: [
                    Text(
                      "SISTEM INFORMASI AKADEMIK",
                      style: TextStyle(
                        color: GlobalVariables.baseColor,
                        fontSize: MediaQuery.sizeOf(context).width / 19,
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                    Text(
                      'Universitas Developer',
                      style: TextStyle(
                        color: const Color(0xFF2DBAB1),
                        fontSize: MediaQuery.sizeOf(context).width / 20,
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
                  GlobalVariables.logo,
                  fit: BoxFit.fill,
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
                              child: SizedBox(
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
                  }

                  if (state is FailureLogin) {
                    Navigator.pop(context);
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
  }
}
