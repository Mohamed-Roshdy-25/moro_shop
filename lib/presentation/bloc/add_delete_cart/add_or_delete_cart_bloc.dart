import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moro_shop/app/di.dart';
import 'package:moro_shop/app/extensions.dart';
import 'package:moro_shop/domain/use_case/add_delete_carts_use_case.dart';

part 'add_or_delete_cart_event.dart';
part 'add_or_delete_cart_state.dart';

class AddOrDeleteCartBloc extends Bloc<AddOrDeleteCartEvent, AddOrDeleteCartState> {
  final AddOrDeleteCartsUseCase _addOrDeleteCartsUseCase;
  Map<int, bool> inCarts = {};
  Map<int, bool> isCartProductLoading = {};

  AddOrDeleteCartBloc(this._addOrDeleteCartsUseCase) : super(AddOrDeleteCartInitial()) {
    on<AddOrDeleteCartEvent>((event, emit) async {
      if(event is PostAddOrDeleteCartsEvent){
        await Future.wait([_changeCart(emit, event)]);
      }
    });
  }


  Future<void> _changeCart(emit, event) async {
    isCartProductLoading[event.productId] = true;
    emit(AddOrDeleteCartsLoadingState());

    (await _addOrDeleteCartsUseCase.execute(
        AddOrDeleteCartsUseCaseInput(
            event.productId, event.categoryId)))
        .fold((failure) {
      isCartProductLoading[event.productId] = false;
      emit(AddOrDeleteCartsErrorState(failure.message));
    }, (data) {
      isCartProductLoading[event.productId] = false;
      emit(AddOrDeleteCartsLoadingState());
      inCarts[event.productId] = !inCarts[event.productId].orFalse();
      emit(AddOrDeleteCartsSuccessState(data.message));
    });
  }
}
