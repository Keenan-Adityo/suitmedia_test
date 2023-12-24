import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_test/view/widgets/user_card.dart';
import 'package:suitmedia_test/view_model/providers/suitmedia_provider.dart';
import 'package:suitmedia_test/styles/text_styles.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SuitmediaProvider>().getUser();
    });
  }

  @override
  Widget build(BuildContext context) {
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
          "Third Screen",
          style: kHeading2,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 15),
        child: Consumer<SuitmediaProvider>(builder: (context, provider, child) {
          return LazyLoadScrollView(
            scrollOffset: 100,
            onEndOfPage: () {
              if (provider.data.isNotEmpty) {
                if (provider.data.length != provider.total) {
                  context.read<SuitmediaProvider>().getUser();
                }
              }
            },
            child: const ListCard(),
          );
        }),
      ),
    );
  }
}


