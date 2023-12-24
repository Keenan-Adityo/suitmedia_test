import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_test/utils/boxes.dart';
import 'package:suitmedia_test/view/pages/first_screen.dart';
import 'package:suitmedia_test/view_model/models/user.dart';
import 'package:suitmedia_test/view_model/providers/suitmedia_provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ListUserAdapter());
  Hive.registerAdapter(UserAdapter());
  boxListUser = await Hive.openBox<ListUser>('listUserBox');
  boxUser = await Hive.openBox<User>('user');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SuitmediaProvider>(
          create: (context) => SuitmediaProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
          useMaterial3: true,
        ),
        home: FirstScreen(),
      ),
    );
  }
}
