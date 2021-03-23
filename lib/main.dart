import 'package:admin/Bloc/admin_bloc.dart';
import 'package:admin/Home/Home_page.dart';
// import 'package:admin/statistics/statistics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => AdminBloc()..init(),
          dispose: (_, AdminBloc b) => b.dispose(),
        ),
      ],
      child: MaterialApp(
        title: 'YLC Admin',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
