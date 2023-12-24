import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_test/view/pages/second_screen.dart';
import 'package:suitmedia_test/view_model/providers/suitmedia_provider.dart';
import 'package:suitmedia_test/view/widgets/custom_button.dart';

class FirstScreen extends StatelessWidget {
  final TextEditingController name = TextEditingController();
  final TextEditingController palindrome = TextEditingController();
  FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: screen.height,
        width: screen.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.only(left: 33, right: 33, top: 142),
            child: Column(
              children: [
                const CircleAvatar(
                  backgroundColor: Color.fromRGBO(154, 196, 206, 1),
                  radius: 60,
                  child: Icon(
                    Icons.person_add_alt_1,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 51,
                ),
                TextField(
                  controller: name,
                  style: const TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                      hintText: "Name",
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 20,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: palindrome,
                  style: const TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                      hintText: "Palindrome",
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 20,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
                const SizedBox(
                  height: 45,
                ),
                CustomButton(
                    text: "CHECK",
                    callback: () {
                      context
                          .read<SuitmediaProvider>()
                          .onCheck(palindrome.text);

                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: Consumer<SuitmediaProvider>(
                                  builder: (context, provider, child) {
                                    return Text(provider.dialog);
                                  },
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ));
                    }),
                CustomButton(
                    text: "NEXT",
                    callback: () {
                      context.read<SuitmediaProvider>().changeName(name.text);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SecondScreen(),
                          ));
                    }),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
