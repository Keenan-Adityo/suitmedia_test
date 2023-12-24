import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_test/view/pages/third_screen.dart';
import 'package:suitmedia_test/view_model/providers/suitmedia_provider.dart';
import 'package:suitmedia_test/styles/text_styles.dart';
import 'package:suitmedia_test/view/widgets/custom_button.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        shape: const Border(
            bottom:
                BorderSide(width: 1, color: Color.fromRGBO(226, 227, 228, 1))),
        title: Text(
          "Second Screen",
          style: kHeading2,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          height: screen.height - 90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome",
                    style: kBodyText,
                  ),
                  Consumer<SuitmediaProvider>(
                    builder: (context, provider, child) => Text(
                      provider.name,
                      style: kHeading1,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: Consumer<SuitmediaProvider>(
                  builder: (context, provider, child) => Text(
                    provider.username,
                    textAlign: TextAlign.center,
                    style: kHeading1,
                  ),
                ),
              ),
              CustomButton(
                  text: "Choose a User",
                  callback: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ThirdScreen(),
                        ));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
