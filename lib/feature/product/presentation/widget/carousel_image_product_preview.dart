// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/constant/constant.dart';
import '../../domain/entities/product_item.dart';

class CarouselImageProductPreview extends StatefulWidget {
  final PageController pageController;
  final List<UrlImageProduct> urlImages;
  const CarouselImageProductPreview({
    Key? key,
    required this.pageController,
    required this.urlImages,
  }) : super(key: key);

  @override
  State<CarouselImageProductPreview> createState() =>
      _CarouselImageProductPreviewState();
}

class _CarouselImageProductPreviewState
    extends State<CarouselImageProductPreview> {
  late int lengthImage;
  int currentIndex = 0;
  Timer? timerPageController;

  @override
  void initState() {
    lengthImage = widget.urlImages.length;
    if (lengthImage > 1) {
      timerPageController = Timer.periodic(const Duration(seconds: 4), (timer) {
        widget.pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        );
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    timerPageController?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: widget.pageController,
          onPageChanged: (value) {
            setState(() {
              currentIndex = value % lengthImage;
            });
          },
          itemBuilder: (context, index) {
            return Image.network(
              'http://$baseUrl${widget.urlImages[index % lengthImage].urlImage}',
              fit: BoxFit.fill,
            );
          },
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade400.withOpacity(.6),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            child: Text(
              '${currentIndex + 1}/$lengthImage',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
