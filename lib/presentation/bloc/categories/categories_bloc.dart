// ignore_for_file: void_checks

import 'dart:ffi';
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/domain/use_case/categories_use_case.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoriesUseCase categoryUseCase;
  List<CategoryModel>? categories;

  CategoryBloc(this.categoryUseCase) : super(CategoryInitial()) {
    on<CategoryEvent>(
      (event, emit) async {
        if (event is GetCategoriesEvent) {
          await Future.wait([_getCategories(emit,event)]);
        }
      },
    );
  }


  Future<void> _getCategories(emit,event) async {
    emit(CategoriesLoadingState());

    (await categoryUseCase.execute(Void)).fold(
          (failure) {
        emit(CategoriesErrorState(failure.message));
      },
          (data) {
        categories = data.categoriesDataModel?.categoriesModel;
        emit(CategoriesSuccessState(data));
      },
    );
  }
}
