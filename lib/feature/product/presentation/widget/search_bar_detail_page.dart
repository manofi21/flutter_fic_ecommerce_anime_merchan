import 'dart:async';

import 'package:flutter/material.dart';
 import 'package:flutter_fic_ecommerce_warung_comicon/feature/product/presentation/widget/icon_detail_bar.dart';

import '../../../cart/presentation/widget/cart_badges.dart';
import '../../../search/presentation/page/search_page.dart';
import 'button_to_search_page.dart';

class SearchBarDetailPage extends StatefulWidget {
  final ScrollController scrollController;
  const SearchBarDetailPage({super.key, required this.scrollController});

  @override
  State<SearchBarDetailPage> createState() => _SearchBarDetailPageState();
}

class _SearchBarDetailPageState extends State<SearchBarDetailPage>
    with SingleTickerProviderStateMixin {
  final tagHero = "hero_from_detail_page";

  late ScrollController scrollController;
  late Timer timer;
  var _opacity = 0.0;
  List<String> texts = ['Gundam', 'Sailor Moon', 'Naruto'];
  int currentIndex = 0;
  final imageHeight = 300;

  @override
  void initState() {
    scrollController = widget.scrollController;
    scrollController.addListener(_handleScroll);
    startAnimation();
    super.initState();
  }

  void _handleScroll() {
    double scrollOffset = scrollController.offset;
    setState(() {
      if (scrollOffset < imageHeight) {
        _opacity = scrollOffset / imageHeight;
      }
    });
  }

  void startAnimation() {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        final newIndex = currentIndex + 1;
        currentIndex = newIndex == texts.length ? 0 : newIndex;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    scrollController.removeListener(_handleScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Container(
      color: Color.lerp(null, Colors.white, _opacity),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: iconDetailBar(opacity: _opacity, icon: Icons.arrow_back),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                if (_opacity > 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SearchPageBloc(tagHero: tagHero),
                    ),
                  );
                }
              },
              child: buttonToSearchPage(
                opacity: _opacity,
                currentIndex: currentIndex,
                texts: texts,
                tagHero: tagHero,
              ),
            ),
          ),
          Row(
            children: [
              iconDetailBar(opacity: _opacity, icon: Icons.share_outlined),
              CartBadges(
                badgesEnd: 3,
                child: iconDetailBar(
                  opacity: _opacity,
                  icon: Icons.shopping_cart_rounded,
                ),
              ),
              // InkWell(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (_) => const CartPage(),
              //       ),
              //     );
              //   },
              //   child: iconDetailBar(
              //     opacity: _opacity,
              //     icon: Icons.shopping_cart_rounded,
              //     // icon: Icons.shopping_basket_outlined,
              //   ),
              // ),
              iconDetailBar(opacity: _opacity, icon: Icons.menu)
            ],
          )
        ],
      ),
    );
  }
}
