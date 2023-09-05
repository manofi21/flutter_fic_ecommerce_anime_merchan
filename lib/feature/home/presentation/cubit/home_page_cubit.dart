import 'package:bloc/bloc.dart';
import '../../../order_history/presentation/bloc/order_history_bloc.dart';
import '../../../product/presentation/bloc/product_bloc.dart';
import 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  final OrderHistoryBloc orderHistoryBloc;
  final ProductBloc productBloc;
  HomePageCubit(this.orderHistoryBloc, this.productBloc) : super(0);

  void onChangePage(int index) {
    if (index == 0) {
      productBloc.add(ProductLoadedEvent());
    }
    
    if (index == 2) {
      orderHistoryBloc.add(OrderHistoryLoadData());
    }
    emit(index);
  }
}
