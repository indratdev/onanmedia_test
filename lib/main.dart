import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onanmedia_test/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:onanmedia_test/presentation/bloc/classroom_bloc/classroom_bloc.dart';
import 'package:onanmedia_test/presentation/bloc/student_bloc/student_bloc.dart';
import 'package:onanmedia_test/presentation/pages/login/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

      // options: DefaultFirebaseOptions.currentPlatform,
      options: const FirebaseOptions(
    apiKey: "AIzaSyD-yvoLPnzOfjb0tgCz80lyAcSYpnPswr4",
    appId: "1:889765789214:android:0a6f78f519e283d662380f",
    messagingSenderId: "1043666322353",
    projectId: "onanmedia-1b9ca",
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => ClassroomBloc(),
        ),
        BlocProvider(
          create: (context) => StudentBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
              color: Color(0xFF21ABA5),
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Color(0xFF21ABA5),
            )),
        home: LoginScreen(),
      ),
    );
  }
}
