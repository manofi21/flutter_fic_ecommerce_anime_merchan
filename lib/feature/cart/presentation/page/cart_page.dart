import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/core/show_dialog/show_confirm_dialog.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/core/show_dialog/show_error_dialog.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/order/presentation/widget/button_order_user_product.dart';

import '../../../../core/base_widget/price_text_widget.dart';
import '../../../../core/constant/constant.dart';
import '../bloc/cart_bloc.dart';
import '../widget/count_product_in_cart_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cartBloc = context.watch<CartBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Title(
          color: Colors.blue,
          title: 'Cart',
          child: const Text('Cart'),
        ),
      ),
      bottomNavigationBar:
          ButtonOrderUserProduct(listCartProduct: cartBloc.state),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final cartBloc = context.watch<CartBloc>();

          return ListView.builder(
            itemCount: state.length,
            physics: const ScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final listItem = state[index].productItem.urlImages;
              final productId = state[index].productItem.productId;
              final productName = state[index].productItem.productName;
              final productCartPrice = state[index].priceAfterCalculated;

              final productInCart = cartBloc.countProductInCart(productId);

              return Card(
                elevation: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Container(
                        constraints:
                            const BoxConstraints(maxHeight: 80, maxWidth: 80),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              'http://$baseUrl${listItem.first}',
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        productName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      subtitle: PriceTextWidget(price: productCartPrice),
                      trailing: InkWell(
                        onTap: () {
                          showConfirmDialog(
                            context: context,
                            message: "Apakah anda yakin ingin "
                                "menghapus dari keranjang?",
                            ok: () {
                              cartBloc.discardProduct(productId: productId);
                            },
                          );
                        },
                        child: const Icon(Icons.delete),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 25,
                      width: 120,
                      child: CountProductInCartWidget(
                        countProductWidget: Text(productInCart.toString()),
                        onAdd: () {
                          cartBloc.incrementProduct(
                            productId: productId,
                            onHitLimitQuality: () {
                              showErrorDialog(context: context, message: 'Product yang di input tidak bisa lebih banyak lagi karena sudah menyentuh limit');
                            }
                          );
                        },
                        onSubtract: () {
                          if (productInCart == 1) {
                            showConfirmDialog(
                              context: context,
                              message: "Apakah anda yakin ingin "
                                  "menghapus dari keranjang?",
                              ok: () {
                                cartBloc.decrementProduct(productId: productId);
                              },
                            );
                            return;
                          }
                          cartBloc.decrementProduct(productId: productId);
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
