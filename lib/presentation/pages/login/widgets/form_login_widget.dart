import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onanmedia_test/presentation/bloc/auth_bloc/auth_bloc.dart';

import '../../../../shared/utils/global_variables.dart';
import '../../../../widgets/custom_textformfield_widget.dart';

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
                  elevation: 5,
                  shadowColor: Colors.black,
                  backgroundColor: GlobalVariables.baseColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: () async {
                  BlocProvider.of<AuthBloc>(context).add(LoginEvent(
                    email: emailController.text,
                    password: passwordController.text,
                  ));
                  // BlocProvider.of<AuthBloc>(context).add(
                  //   LoginEvent(
                  //     email: "indrat.saputra@mail.com",
                  //     password: "123123",
                  //   ),
                  // );
                },
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: MediaQuery.sizeOf(context).width / 18,
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
