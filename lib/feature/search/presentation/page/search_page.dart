import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/product/presentation/page/detail_product_page.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/search/presentation/widget/search_text_field.dart';

import '../../../../core/constant/constant.dart';
import '../../../../locator.dart';
import '../bloc/search_product_bloc.dart';
import '../widget/list_searched_product.dart';

class SearchPageBloc extends StatelessWidget {
  final String tagHero;
  const SearchPageBloc({super.key, required this.tagHero});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchProductBloc>(
      create: (_) => getIt<SearchProductBloc>(),
      child: SearchPage(tagHero: tagHero),
    );
  }
}

class SearchPage extends StatefulWidget {
  final String tagHero;
  const SearchPage({super.key, required this.tagHero});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchProductBloc searchProductBloc;

  @override
  void initState() {
    super.initState();
    searchProductBloc = context.read<SearchProductBloc>();
  }

  @override
  void dispose() {
    onCloseBloc();
    super.dispose();
  }

  Future<void> onCloseBloc() async {
    await searchProductBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
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
                      tag: widget.tagHero,
                      child: const Material(
                        child: SearchTextField(),
                      ),
                    ),
                  )
                ],
              ),
            ),
            BlocBuilder<SearchProductBloc, SearchProductState>(
              builder: (context, state) {
                if (state is SearchProductLoaded) {
                  final itemList = state.searchedListItem;
                  return Expanded(
                    child: ListSearchedProduct(itemList: itemList),
                  );
                }

                if (state is SearchProductLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.search,
                        size: 50,
                      ),
                      Text("Cari Product Yang di Inginkan")
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
