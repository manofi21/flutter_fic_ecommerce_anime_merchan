import 'package:flutter/material.dart';
// import 'package:flutter_fic_ecommerce_warung_comicon/feature/product/presentation/page/product_page.dart';

import '../../../dashboard/presentation/page/dashboard_page.dart';
import '../../../order_history/presentation/page/order_history_page.dart';

class HomePageViweWidget extends StatefulWidget {
  final int pageIndex;
  const HomePageViweWidget({super.key, required this.pageIndex});

  @override
  State<HomePageViweWidget> createState() => _HomePageViweWidgetState();
}

class _HomePageViweWidgetState extends State<HomePageViweWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child:  SafeArea(
        child: IndexedStack(
          index: widget.pageIndex,
          children: [const DashboardPage(), Container(), const OrderHistoryPage()],
        ),
      ),
    );
  }
}
