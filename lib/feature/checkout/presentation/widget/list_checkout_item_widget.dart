import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base_widget/price_text_widget.dart';
import '../../../../core/constant/constant.dart';
import '../../../cart/domain/entities/cart_product.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';

class ListCheckoutItemBlocBuilder extends StatelessWidget {
  const ListCheckoutItemBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, _) {
        final cartBloc = context.read<CartBloc>();
        return Card(
          child: ListCheckoutItemWidget(checkedList: cartBloc.checkedList()),
        );
      },
    );
  }
}

class ListCheckoutItemWidget extends StatelessWidget {
  final List<CartProduct> checkedList;
  const ListCheckoutItemWidget({super.key, required this.checkedList});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: checkedList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Divider(
            height: 4.0,
          ),
        );
      },
      itemBuilder: (BuildContext context, int index) {
        final currentState = checkedList[index];
        final listItem = currentState.productItem.urlImages;

        return SizedBox(
          height: 90,
          child: ListTile(
            leading: Container(
              constraints: const BoxConstraints(maxHeight: 80, maxWidth: 80),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'http://$baseUrl${listItem.first}',
                  ),
                ),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentState.productItem.productName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${currentState.productItemCount} Barang',
                  style: const TextStyle(fontSize: 13),
                ),
                PriceTextWidget(
                  price: currentState.productItem.productPrice.toDouble(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
