part of 'categories_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
}

class CategoryInitial extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoriesLoadingState extends CategoryState{
  @override
  List<Object?> get props => [];
}

class CategoriesSuccessState extends CategoryState{
  final CategoriesModel categoryModel;

  const CategoriesSuccessState(this.categoryModel);

  @override
  List<Object?> get props => [categoryModel];
}

class CategoriesErrorState extends CategoryState{
  final String message;

  const CategoriesErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

