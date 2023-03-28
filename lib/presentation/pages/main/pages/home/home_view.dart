import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moro_shop/app/di.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/presentation/bloc/categories/categories_bloc.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:moro_shop/presentation/common/widgets/search_bar.dart';
import 'package:moro_shop/presentation/pages/widgets/home_product_widget.dart';
import 'package:moro_shop/presentation/resources/color_manager.dart';
import 'package:moro_shop/presentation/resources/strings_manager.dart';



class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return _getContentWidget();
  }

  Widget _getContentWidget() {
    return BlocProvider<CategoryBloc>(
      create: (context) => instance<CategoryBloc>()..add(GetCategoriesEvent()),
      child: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {
          _onCategoriesErrorState(state,context);
        },
        builder: (context, state) {
          List<CategoryModel>? categories =
              BlocProvider.of<CategoryBloc>(context).categories;
          if (categories != null && categories.isNotEmpty) {
            return DefaultTabController(
              length: categories.length,
              child: Column(
                children: [
                  _searchBAr(),
                  _tabBar(categories),
                  const SizedBox(height: 10),
                  _tabView(categories),
                ],
              ),
            );
          } else if (state is CategoriesErrorState) {
            return ErrorState(
                    StateRendererType.fullScreenErrorState, state.message)
                .getScreenWidget(context, buttonTitle: AppStrings.retryAgain,
                    retryActionFunction: () async {
              BlocProvider.of<CategoryBloc>(context).add(GetCategoriesEvent());
              await Future.delayed(Duration.zero);
            });
          } else {
            return LoadingState(
                    stateRendererType: StateRendererType.fullScreenLoadingState)
                .getScreenWidget(context);
          }
        },
      ),
    );
  }

  _searchBAr() {
    return const Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: SearchBar(
        searchBarTitle: 'search product',
      ),
    );
  }

  _tabBar(List<CategoryModel> data) {
    return SizedBox(
      height: 65,
      child: TabBar(
        physics: const BouncingScrollPhysics(),
        indicatorColor: Colors.transparent,
        labelColor: ColorManager.white,
        unselectedLabelColor: ColorManager.primary,
        indicatorSize: TabBarIndicatorSize.label,
        isScrollable: true,
        onTap: (value) {
          setState(() {
            selectedValue = value;
          });
        },
        tabs: List.generate(data.length, (index) {
          return Container(
            width: 100,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                colors: selectedValue == index
                    ? [
                        ColorManager.primary,
                        Theme.of(context).colorScheme.secondary
                      ]
                    : [Colors.grey.shade400, Colors.grey.shade400],
              ),
              boxShadow: selectedValue == index
                  ? [
                      BoxShadow(
                        color: ColorManager.primary,
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: const Offset(0, 1),
                      ),
                    ]
                  : null,
            ),
            child: Text(data[index].name, textAlign: TextAlign.center),
          );
        }),
      ),
    );
  }

  _tabView(List<CategoryModel> data) {
    return Expanded(
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(data.length, (index) {
          return HomeProductsWidget(categoryId: data[index].id);
        }),
      ),
    );
  }

  Future<void> _onCategoriesErrorState(CategoryState state,BuildContext context) async {
    if (state is CategoriesErrorState) {
      if (state.message == AppStrings.unKnownError) {
        BlocProvider.of<CategoryBloc>(context)
            .add(GetCategoriesEvent());
        await Future.delayed(Duration.zero);
      }
    }
  }

  @override
  void dispose() {
    instance<CategoryBloc>().close();
    super.dispose();
  }
}
