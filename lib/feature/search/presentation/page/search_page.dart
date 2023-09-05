import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/product/presentation/page/detail_product_page.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/search/presentation/widget/search_text_field.dart';

import '../../../../core/constant/constant.dart';
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
                  const Expanded(
                    child: Hero(
                      tag: "onClickTextField",
                      child: Material(
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

                  if (itemList.isEmpty) {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.error_outline,
                            size: 50,
                          ),
                          Text("Pencarian Tidak di Temukan")
                        ],
                      ),
                    );
                  }

                  return Expanded(
                    child: ListView.separated(
                      itemCount: itemList.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 20);
                      },
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailProductPage(
                                  productItem: itemList[index],
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: index == 0 ? 20 : 0,
                                bottom: index == itemList.length - 1 ? 20 : 0),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(width: 2)),
                                  width: double.infinity,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 60,
                                        height: 60,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                'http://$baseUrl${itemList[index].urlImages.first.urlSmallImage}'),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          itemList[index].productName,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          softWrap: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 0.5,
                                  color: Colors.black.withOpacity(.5),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
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
