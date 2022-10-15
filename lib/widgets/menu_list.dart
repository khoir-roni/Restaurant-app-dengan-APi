import 'package:flutter/material.dart';

import '../theme/theme.dart';

class MenuList extends StatelessWidget {
  final List menu;
  const MenuList({
    Key? key,
    required this.menu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
          minHeight: 20, minWidth: double.infinity, maxHeight: 50),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: menu.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  menu[index].name,
                  style: const TextStyle(
                      color: primaryColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                            blurRadius: 1,
                            offset: Offset(1, 1),
                            color: Colors.white)
                      ]),
                ),
              ));
        },
      ),
    );
  }
}
