import 'package:flutter/material.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/product/presentation/page/product_page.dart';

import '../widget/search_bar_dashboard_widget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SearchBarDashboardWidget(),
        Expanded(child: ProductPage()),
      ],
    );
  }
}