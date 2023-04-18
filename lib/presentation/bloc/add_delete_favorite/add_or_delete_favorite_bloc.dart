import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moro_shop/app/extensions.dart';
import 'package:moro_shop/domain/use_case/add_delete_favorites_use_case.dart';

part 'add_or_delete_favorite_event.dart';
part 'add_or_delete_favorite_state.dart';

class AddOrDeleteFavoriteBloc
    extends Bloc<AddOrDeleteFavoriteEvent, AddOrDeleteFavoriteState> {
  final AddOrDeleteFavoritesUseCase _addOrDeleteFavoritesUseCase;
  Map<int, bool> inFavorites = {};
  Map<int, bool> isFavoriteProductLoading = {};

  AddOrDeleteFavoriteBloc(this._addOrDeleteFavoritesUseCase) : super(AddOrDeleteFavoriteInitial()) {
    on<AddOrDeleteFavoriteEvent>((event, emit) async {
      if (event is PostAddOrDeleteFavoritesEvent) {
        await Future.wait([_changeFavorite(emit, event)]);
      }
    });
  }

  Future<void> _changeFavorite(emit, event) async {
    isFavoriteProductLoading[event.productId] = true;
    emit(AddOrDeleteFavoritesLoadingState());

    (await _addOrDeleteFavoritesUseCase.execute(
            AddOrDeleteFavoritesUseCaseInput(
                event.productId, event.categoryId)))
        .fold((failure) {
      isFavoriteProductLoading[event.productId] = false;
      emit(AddOrDeleteFavoritesErrorState(failure.message));
    }, (data) {
      isFavoriteProductLoading[event.productId] = false;
      emit(AddOrDeleteFavoritesLoadingState());
      inFavorites[event.productId] = !inFavorites[event.productId].orFalse();
      emit(AddOrDeleteFavoritesSuccessState(data.message));
    });
  }
}
