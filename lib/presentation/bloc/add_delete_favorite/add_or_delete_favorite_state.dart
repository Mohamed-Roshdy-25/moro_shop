part of 'add_or_delete_favorite_bloc.dart';

abstract class AddOrDeleteFavoriteState extends Equatable {
  const AddOrDeleteFavoriteState();
}

class AddOrDeleteFavoriteInitial extends AddOrDeleteFavoriteState {
  @override
  List<Object> get props => [];
}

class AddOrDeleteFavoritesLoadingState extends AddOrDeleteFavoriteState {
  @override
  List<Object?> get props => [];
}

class AddOrDeleteFavoritesSuccessState extends AddOrDeleteFavoriteState {
  final String message;

  const AddOrDeleteFavoritesSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class AddOrDeleteFavoritesErrorState extends AddOrDeleteFavoriteState {
  final String message;

  const AddOrDeleteFavoritesErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
