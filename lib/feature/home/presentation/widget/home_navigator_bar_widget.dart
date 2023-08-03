import 'package:flutter/material.dart';

class HomeNavigatorBarWidget extends StatefulWidget {
  final int pageIndex;
  final void Function(int) onTabClick;
  const HomeNavigatorBarWidget(
      {super.key,
      required this.onTabClick, required this.pageIndex});

  @override
  State<HomeNavigatorBarWidget> createState() => _HomeNavigatorBarWidgetState();
}

class _HomeNavigatorBarWidgetState extends State<HomeNavigatorBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: widget.onTabClick,
      currentIndex: widget.pageIndex,
      items: const [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: 'Favorite',
          icon: Icon(Icons.favorite_outline_outlined),
        ),
        BottomNavigationBarItem(
          label: 'Transaction',
          icon: Icon(Icons.shopping_basket_sharp),
        ),
      ],
    );
  }
}
