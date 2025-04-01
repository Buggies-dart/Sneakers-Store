import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sneaker_store_app/Widgets/userOnboarding/splashscreen.dart';
import 'package:sneaker_store_app/controllers/state_management.dart';
import '../firebase_options.dart';



void main() async
{   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const ProviderScope(child:  SneakerStore()));
}
final myNotifProvider = ChangeNotifierProvider<ProductsState>((ref)=> ProductsState());

class SneakerStore extends StatelessWidget {
  const SneakerStore({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.black,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme:  AppBarTheme(
    color: Colors.blue[400],
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
 headlineLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
 bodySmall: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18), ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.redAccent,
    textTheme: ButtonTextTheme.primary,
  ),
);
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme:const AppBarTheme(
    color: Colors.black,
    iconTheme:  IconThemeData(color: Colors.white),
  ),
  textTheme: const TextTheme(
   bodyLarge: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(color: Colors.black54, fontSize: 18),
    titleLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 35),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.redAccent,
    textTheme: ButtonTextTheme.primary,
  ),
);
return MaterialApp( title: 'Buggies FootWear Store', debugShowCheckedModeBanner: false,
    theme: lightTheme,
    darkTheme: darkTheme,
     themeMode: ThemeMode.system,
      home: const SplashScreen()
    );
  }
}