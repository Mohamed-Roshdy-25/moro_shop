import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moro_shop/domain/use_case/delete_favorite_use_case.dart';

part 'delete_favorite_event.dart';
part 'delete_favorite_state.dart';

class DeleteFavoriteBloc extends Bloc<DeleteFavoriteEvent, DeleteFavoriteState> {
  final DeleteFavoriteUseCase _deleteFavoriteUseCase;
  Map<int, bool> isFavoritesProductLoading = {};

  DeleteFavoriteBloc(this._deleteFavoriteUseCase) : super(DeleteFavoriteInitial()) {
    on<DeleteFavoriteEvent>((event, emit) async {
      if(event is PostDeleteFavoriteEvent){
        isFavoritesProductLoading[event.favoriteItemId] = false;
        await Future.wait([deleteFavorite(event, emit)]);
      }
    });
  }

  Future<void> deleteFavorite(event, emit) async {
    isFavoritesProductLoading[event.favoriteItemId] = true;
    emit(DeleteFavoriteLoadingState());

    (await _deleteFavoriteUseCase.execute(
    DeleteFavoriteUseCaseInput(
    event.favoriteItemId))).fold((failure) {

    isFavoritesProductLoading[event.favoriteItemId] = false;
    emit(DeleteFavoriteErrorState(failure.message));

    }, (data) {
    emit(DeleteFavoriteSuccessState(data.message));
    });
  }
}
