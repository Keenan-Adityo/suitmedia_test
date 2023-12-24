import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_test/view_model/models/user.dart';
import 'package:suitmedia_test/view_model/providers/suitmedia_provider.dart';
import 'package:suitmedia_test/styles/text_styles.dart';
import 'package:suitmedia_test/utils/states_enum.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

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

class ListCard extends StatelessWidget {
  const ListCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SuitmediaProvider>(
      builder: (context, provider, child) {
        if (provider.state == RequestState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.state == RequestState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: (provider.data.length != provider.total)
                ? provider.data.length + 1
                : provider.data.length,
            itemBuilder: (context, index) {
              return (index < provider.data.length)
                  ? CustomCard(item: provider.data[index])
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
              // if (index < provider.data.length) {
              //   User item = provider.data[index];
              //   return CustomCard(item: item);
              // } else {
              //   return const Center(
              //     child: CircularProgressIndicator(),
              //   );
              // }
            },
          );
        }
        return Center(
            child: Text(
          "No data",
          style: kHeading3,
        ));
      },
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.item,
  });

  final User item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context
            .read<SuitmediaProvider>()
            .selectUsername("${item.firstName} ${item.lastName}");
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 1, color: Color.fromRGBO(226, 227, 228, 1))),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(item.avatar),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item.firstName} ${item.lastName}",
                  style: kHeading3,
                ),
                Text(
                  item.email,
                  style: kSubtitle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
