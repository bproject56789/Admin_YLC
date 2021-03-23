import 'package:flutter/material.dart';

class DrawerItem {
  final String title;
  final IconData icon;

  DrawerItem(this.title, this.icon);
}

final List<DrawerItem> drawerItems = [
  // DrawerItem("Statistics", Icons.multiline_chart_rounded),
  DrawerItem("All", Icons.group_outlined),
  DrawerItem("Members", Icons.person_outline_rounded),
  DrawerItem("Advocates", Icons.business_center_outlined),
  DrawerItem("Suspended", Icons.do_disturb_alt_sharp),
  DrawerItem("Questions", Icons.question_answer),
];

class CDrawer extends StatelessWidget {
  final ValueChanged<int> onPageChanged;

  const CDrawer({Key key, this.onPageChanged}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(300),
        ),
        child: Drawer(
          child: Container(
            color: Colors.amber.withOpacity(0.8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                drawerItems.length,
                (index) => ListTile(
                  leading: Icon(drawerItems[index].icon),
                  title: Text(drawerItems[index].title),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    onPageChanged?.call(index);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
