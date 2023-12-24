import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_test/styles/text_styles.dart';
import 'package:suitmedia_test/utils/states_enum.dart';
import 'package:suitmedia_test/view_model/models/user.dart';
import 'package:suitmedia_test/view_model/providers/suitmedia_provider.dart';

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
                  ? UserCard(item: provider.data[index])
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

class UserCard extends StatelessWidget {
  const UserCard({
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
