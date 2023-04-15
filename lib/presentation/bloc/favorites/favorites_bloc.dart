// ignore_for_file: void_checks

import 'dart:async';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moro_shop/app/di.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/domain/use_case/favorites_use_case.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesUseCase _favoritesUseCase;
  List<FavoriteProductModel>? favorites;

  FavoritesBloc(this._favoritesUseCase) : super(FavoritesInitial()) {
    on<FavoritesEvent>((event, emit) async {
      if (event is GetFavoritesEvent) {
        await initAppModule();
        await Future.wait([_getFavorites(event, emit)]);
      }
    });
  }

  Future<void> _getFavorites(event, emit) async {
    emit(GetFavoritesLoadingState());

    (await _favoritesUseCase.execute(Void)).fold(
      (failure) {
        emit(GetFavoritesErrorState(failure.message));
      },
      (data) {
        favorites = data.favoriteAllProductsDataModel?.favoriteProducts;
        emit(GetFavoritesSuccessState(data));
      },
    );
  }
}
