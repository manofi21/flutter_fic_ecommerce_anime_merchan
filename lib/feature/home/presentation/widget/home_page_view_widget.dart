import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/home/presentation/cubit/home_page_state.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/product/presentation/page/product_page.dart';

import '../cubit/home_page_cubit.dart';

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
      child: IndexedStack(
        index: widget.pageIndex,
        children: [const ProductPage(), Container(), Container()],
      ),
    );
  }
}
