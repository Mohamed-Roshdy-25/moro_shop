part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();
}

class FavoritesInitial extends FavoritesState {
  @override
  List<Object> get props => [];
}

class GetFavoritesLoadingState extends FavoritesState{
  @override
  List<Object?> get props => [];
}

class GetFavoritesSuccessState extends FavoritesState{
  final FavoritesAllDataModel favoritesAllDataModel;

  const GetFavoritesSuccessState(this.favoritesAllDataModel);

  @override
  List<Object?> get props => [favoritesAllDataModel];
}

class GetFavoritesErrorState extends FavoritesState{
  final String message;

  const GetFavoritesErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
