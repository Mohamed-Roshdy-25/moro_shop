part of 'categories_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class GetCategoriesEvent extends CategoryEvent{
  @override
  List<Object?> get props => [];
}