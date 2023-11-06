import 'package:flutter/material.dart';

class InfoListCardWidget extends StatelessWidget {
  const InfoListCardWidget({
    required this.title,
    required this.icon,
    required this.dataList,
    super.key,
  });

  final String title;
  final IconData icon;
  final List<String> dataList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Column(
          children: [
            ListTile(
              leading: Icon(icon),
              title: Text(title.toString(), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            ),
            const Divider(),
            const ListTile(
              leading: Text('No.', style: TextStyle(fontWeight: FontWeight.bold)),
              title: Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Text('Amount', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text((index + 1).toString(), style: const TextStyle(fontSize: 13)),
                    title: Text(dataList[index], style: const TextStyle(fontSize: 13)),
                    trailing: const Text('1000', style: TextStyle(fontSize: 13)),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
