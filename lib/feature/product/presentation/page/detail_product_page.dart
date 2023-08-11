import 'package:flutter/material.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/product/presentation/widget/search_bar_detail_page.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/base_widget/price_text_widget.dart';
import '../../domain/entities/product_item.dart';
import '../widget/button_add_product_to_cart.dart';
import '../widget/carousel_image_product_preview.dart';

class DetailProductPage extends StatefulWidget {
  final ProductItem productItem;
  const DetailProductPage({super.key, required this.productItem});

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  late ScrollController scrollController;
  late PageController pageController;
  var currentIndex = 0;
  var lengthImage = 0;

  @override
  void initState() {
    scrollController = ScrollController();
    pageController = PageController(keepPage: true);
    lengthImage = widget.productItem.urlImages.length;
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productItem = widget.productItem;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Row(children: [
          ButtonAddProductToCart(productItem: productItem, width: size.width / 2),
          Container(
            width: size.width / 2,
            color: Colors.orange,
            child: const Center(child: Text('Langsung Beli')),
          ),
        ]),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: ((size.height * 1) / 2) - 25,
                    child: CarouselImageProductPreview(
                      urlImages: widget.productItem.urlImages,
                      pageController: pageController,
                    )
                  ),
                  Container(
                    color: Colors.grey[300],
                    height: 14.sp,
                  ),
                  Text(productItem.productName),
                  PriceTextWidget(price: productItem.productPrice.toDouble()),
                  Text(productItem.description),
                  Text(productItem.distributor),
                  Text("Source Item : ${productItem.sourceItem}"),
                  Text(
                    "Source Item : ${productItem.typeItem}, ${productItem.subTypeItem}",
                  ),
                  SizedBox(height: size.height),
                ],
              ),
            ),
            SearchBarDetailPage(scrollController: scrollController)
          ],
        ),
      ),
    );
  }
}
