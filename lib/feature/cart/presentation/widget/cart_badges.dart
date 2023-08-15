import 'package:badges/badges.dart' as badges;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/cart/presentation/page/cart_page.dart';
import '../bloc/cart_bloc.dart';

class CartBadges extends StatelessWidget {
  final Widget child;
  final double badgesEnd;
  const CartBadges({Key? key, required this.child, required this.badgesEnd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final getItemCount = state.map((e) => e.productItemCount).toList();
          final countItems = getItemCount.isEmpty ? 0 : getItemCount.reduce((v, e) => v + e);
          return badges.Badge(
            position: badges.BadgePosition.topEnd(end: badgesEnd),
            badgeContent: Text(countItems.toString()),
            showBadge: countItems > 0,
            child: InkWell(
              child: child, 
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CartPage(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
