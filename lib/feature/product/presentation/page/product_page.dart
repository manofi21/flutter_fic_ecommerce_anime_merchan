import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/product/presentation/bloc/product_bloc.dart';

import '../../../cart/presentation/page/cart_page.dart';
import '../widget/grid_product_view.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final accessBloc = context.read<ProductBloc>();
      accessBloc.loadProduct();
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
              child: const SizedBox(
                width: 60,
                child: Icon(Icons.shopping_cart_rounded)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CartPage(),
                  ),
                );
              },
            ),
          ],
          title: Title(
            color: Colors.blue,
            title: 'Product',
            child: const Text('Product'),
          ),
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductStateLoaded) {
              final listProduct = state.listProduct;
              return gridProductPage(
                context,
                listProduct: listProduct,
              );
            }

            if (state is ProductStateLoading) {
              return const Center(
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (state is ProductStateError) {
              return Center(
                child: Text(state.message),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
