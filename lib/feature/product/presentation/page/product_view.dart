import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/product/presentation/bloc/product_bloc.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
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
    return Scaffold(
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductStateLoaded) {
            final listProduct = state.listProduct;
            return ListView.builder(
              itemCount: listProduct.length,
              itemBuilder: (context, index) {
                return Text(listProduct[index].productName);
              },
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
    );
  }
}
