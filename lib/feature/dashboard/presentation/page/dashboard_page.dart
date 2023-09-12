import 'package:flutter/material.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/product/presentation/page/product_page.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../../core/constant/constant.dart';
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
      children: [
        const SearchBarDashboardWidget(),
        CarouselSlider(
          options: CarouselOptions(
            height: 200.0,
            autoPlay: true,
          ),
          items: [
            "http://$baseUrl/uploads/Deidey_Akrilik_e05a81291a.jpg",
            "http://$baseUrl/uploads/Alice_Swort_Art_Online_Images_12175b7b34.jpg",
            "http://$baseUrl/uploads/Hololive_Id_Entity_Official_Fanbook_e5406f7554.jpg"
          ].map((e) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 5.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(width: 1.5)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(e, fit: BoxFit.cover, ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        const Expanded(child: ProductPage()),
      ],
    );
  }
}
