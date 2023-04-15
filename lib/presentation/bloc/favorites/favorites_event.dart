part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();
}

class GetFavoritesEvent extends FavoritesEvent{
  @override
  List<Object?> get props => [];
}