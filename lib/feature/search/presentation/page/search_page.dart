import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/search/presentation/widget/search_text_field.dart';

import '../../../../locator.dart';
import '../bloc/search_product_bloc.dart';

class SearchPageBloc extends StatelessWidget {
  const SearchPageBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchProductBloc>(
      create: (_) => getIt<SearchProductBloc>(),
      child: const SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void dispose() {
    context.read<SearchProductBloc>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Hero(
                  tag: "onClickTextField",
                  child: Material(
                    child: SearchTextField()
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
