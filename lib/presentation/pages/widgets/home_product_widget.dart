
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:moro_shop/app/di.dart';
import 'package:moro_shop/app/extensions.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/presentation/bloc/category_products/category_products_bloc.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:moro_shop/presentation/resources/assets_manager.dart';
import 'package:moro_shop/presentation/resources/color_manager.dart';
import 'package:moro_shop/presentation/resources/strings_manager.dart';


class HomeProductsWidget extends StatefulWidget {
  final int categoryId;

  const HomeProductsWidget({Key? key, required this.categoryId})
      : super(key: key);

  @override
  State<HomeProductsWidget> createState() => _HomeProductsWidgetState();
}

class _HomeProductsWidgetState extends State<HomeProductsWidget> {
  int? productId;

  @override
  Widget build(BuildContext context) {
    return _getContentWidget();
  }

  Widget _getContentWidget() {
    return BlocProvider<CategoryProductsBloc>(
      create: (context) => instance<CategoryProductsBloc>()
        ..add(GetCategoryProductsEvent(widget.categoryId)),
      child: BlocConsumer<CategoryProductsBloc, CategoryProductsState>(
        listener: (context, state) {
          _onProductsErrorState(state,context);
          _onAddOrDeleteFavoriteErrorState(state,context);
        },
        builder: (context, state) {
          List<ProductModel>? products =
              BlocProvider.of<CategoryProductsBloc>(context)
                  .categoryProductsList;

          if (products.isNotEmpty) {
            return _productsGridView(products);
          }
          if (state is GetCategoryProductsErrorState) {
            return ErrorState(
                    StateRendererType.fullScreenErrorState, state.message)
                .getScreenWidget(context, retryActionFunction: () async {
              BlocProvider.of<CategoryProductsBloc>(context)
                  .add(GetCategoryProductsEvent(widget.categoryId));
              await Future.delayed(Duration.zero);
            },buttonTitle: AppStrings.retryAgain);
          } else {
            return LoadingState(
                    stateRendererType: StateRendererType.fullScreenLoadingState)
                .getScreenWidget(context);
          }
        },
      ),
    );
  }

  Widget _productsGridView(List<ProductModel> products) {
    return MasonryGridView.count(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      crossAxisSpacing: 15,
      crossAxisCount: 2,
      itemCount: products.length,
      mainAxisSpacing: 10,
      itemBuilder: (context, index) {
        return singleProductWidget(
          products[index],
          index == (products.length) - 1 ? true : false,
          context,
        );
      },
    );
  }

  singleProductWidget(
      ProductModel product, bool lastItem, BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: ColorManager.white,
            boxShadow: [
              BoxShadow(
                color: ColorManager.primary.withOpacity(.1),
                blurRadius: 5,
                spreadRadius: 1,
                offset: const Offset(1, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _productImage(product),
              Row(
                children: [
                  _productNameAndPrice(product),
                  _favoriteButton(product, context),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height:
              lastItem == true ? MediaQuery.of(context).size.height * 0.15 : 0,
        )
      ],
    );
  }

  Widget _productImage(ProductModel product) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Image(
        image: NetworkImage(
          product.image,
        ),
        errorBuilder: (context, error, stackTrace) {
          return const SizedBox(
            height: 100,
            width: 100,
            child: Center(child: Text('Your connection is week please refresh the page'),),
          );
        },
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _productNameAndPrice(ProductModel product) {
    return Expanded(
      flex: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 5),
            child: Text(
              product.name,
              style: Theme.of(context).textTheme.labelLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              children: [
                Text(
                  "\$${product.price.round()}",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(
                  width: 5,
                ),
                if (product.discount != 0)
                  Text(
                    "\$${product.oldPrice.round()}",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _favoriteButton(ProductModel product, BuildContext context) {
    return Expanded(
      child: BlocProvider.of<CategoryProductsBloc>(context)
              .isLoading[(product.id)]
              .orFalse()
          ? SizedBox(
              height: 30,
              width: 30,
              child: Lottie.asset(JsonAssets.loading),
            )
          : GestureDetector(
              onTap: () async {
                productId = product.id;
                BlocProvider.of<CategoryProductsBloc>(context).add(
                    PostAddOrDeleteFavoritesEvent(
                        product.id, widget.categoryId.toString()));
                await Future.delayed(Duration.zero);
              },
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: BlocProvider.of<CategoryProductsBloc>(context)
                                  .inFavorites[(product.id)] ??
                              false
                          ? [
                              Theme.of(context).colorScheme.secondary,
                              Theme.of(context).primaryColor,
                            ]
                          : [
                              ColorManager.grey,
                              ColorManager.grey,
                            ],
                    ),
                    shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Icon(
                  FontAwesomeIcons.heartPulse,
                  size: 15,
                  color: ColorManager.white,
                ),
              ),
            ),
    );
  }

  Future<void> _onProductsErrorState(CategoryProductsState state,BuildContext context) async {
    if (state is GetCategoryProductsErrorState) {
      if (state.message == AppStrings.unKnownError) {
        BlocProvider.of<CategoryProductsBloc>(context)
            .add(GetCategoryProductsEvent(widget.categoryId));
        await Future.delayed(Duration.zero);
      }
    }
  }

  Future<void> _onAddOrDeleteFavoriteErrorState(CategoryProductsState state,BuildContext context) async {
    if (state is AddOrDeleteFavoritesErrorState) {
      if (state.message == AppStrings.unKnownError) {
        BlocProvider.of<CategoryProductsBloc>(context).add(
            PostAddOrDeleteFavoritesEvent(
                productId.orZero(), widget.categoryId.toString()));
        await Future.delayed(Duration.zero);
      } else {
        Fluttertoast.showToast(
          msg: state.message,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorManager.red,
          textColor: ColorManager.white,
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    }
  }

  @override
  void dispose() {
    instance<CategoryProductsBloc>().close();
    super.dispose();
  }
}
