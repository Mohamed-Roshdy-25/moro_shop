part of 'category_products_bloc.dart';

abstract class CategoryProductsState extends Equatable {
  const CategoryProductsState();
}

class CategoryProductsInitial extends CategoryProductsState {
  @override
  List<Object> get props => [];
}

class GetCategoryProductsLoadingState extends CategoryProductsState {
  @override
  List<Object?> get props => [];
}

class GetCategoryProductsSuccessState extends CategoryProductsState {
  final CategoryAllDataModel categoryAllDataModel;

  const GetCategoryProductsSuccessState(this.categoryAllDataModel);

  @override
  List<Object?> get props => [categoryAllDataModel];
}

class GetCategoryProductsErrorState extends CategoryProductsState {
  final String message;

  const GetCategoryProductsErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class AddOrDeleteFavoritesLoadingState extends CategoryProductsState {
  @override
  List<Object?> get props => [];
}

class AddOrDeleteFavoritesSuccessState extends CategoryProductsState {
  final String message;

  const AddOrDeleteFavoritesSuccessState(this.message);

  @override
  List<Object?> get props => [];
}

class AddOrDeleteFavoritesErrorState extends CategoryProductsState {
  final String message;

  const AddOrDeleteFavoritesErrorState(this.message);

  @override
  List<Object?> get props => [];
}
