import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:moro_shop/app/di.dart';
import 'package:moro_shop/app/extensions.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/presentation/bloc/cart/cart_bloc.dart';
import 'package:moro_shop/presentation/bloc/delete_cart_item/delete_cart_item_bloc.dart';
import 'package:moro_shop/presentation/bloc/update_product_quantity_in_cart/update_product_quantity_in_cart_bloc.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:moro_shop/presentation/resources/assets_manager.dart';
import 'package:moro_shop/presentation/resources/color_manager.dart';
import 'package:moro_shop/presentation/resources/font_manager.dart';
import 'package:moro_shop/presentation/resources/strings_manager.dart';
import 'package:moro_shop/presentation/resources/style_manager.dart';
import 'package:moro_shop/presentation/resources/values_manager.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _cartsBlocProviders(),
      child: _body(context),
    );
  }

  _cartsBlocProviders() => [
        BlocProvider(
          create: (context) => instance<CartBloc>()..add(GetCartEvent()),
        ),
        BlocProvider(
          create: (context) => instance<DeleteCartItemBloc>(),
        ),
        BlocProvider(
          create: (context) => instance<UpdateProductQuantityInCartBloc>(),
        ),
      ];

  Widget _body(context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        _onCartSuccessState(state, context);
      },
      builder: (context, state) {
        List<CartProductModel>? cartItems =
            BlocProvider.of<CartBloc>(context).cartItems;

        if (cartItems != null) {
          if (cartItems.isNotEmpty) {
            return _successGetCart(cartItems);
          } else {
            return _emptyCart();
          }
        } else if (state is GetCartErrorState) {
          return _errorGetCart(state, context);
        } else if (state is CartInitial) {
          return Container();
        } else {
          return _loadingGetCart(context);
        }
      },
    );
  }

  void _onCartSuccessState(state, context) {
    if (state is GetCartSuccessState) {
      List<CartProductModel> products =
          state.cartsAllDataModel.cartAllProductsDataModel?.cartProducts ?? [];

      for (CartProductModel element in products) {
        BlocProvider.of<DeleteCartItemBloc>(context)
            .isCartProductLoading
            .addAll({
          element.cartId: element.product.isLoading,
        });

        BlocProvider.of<UpdateProductQuantityInCartBloc>(context)
            .isUpdateCartProductLoading
            .addAll({
          element.cartId: element.product.isLoading,
        });
      }
    }
  }

  Widget _successGetCart(List<CartProductModel> cartItems) {
    return BlocConsumer<DeleteCartItemBloc, DeleteCartItemState>(
      listener: (context, state) {
        _onDeleteCartItemSuccessState(state, context);
        _onDeleteCartItemErrorState(state, context);
      },
      builder: (context, state) {
        return BlocConsumer<UpdateProductQuantityInCartBloc,
            UpdateProductQuantityInCartState>(
          listener: (context, state) {
            _onUpdateCartItemQuantitySuccessState(state, context);
            _onUpdateCartItemQuantityErrorState(state, context);
          },
          builder: (context, state) {
            return Stack(
              children: [
                _buildCartList(cartItems),
                _buildPaymentWidget(context),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildPaymentWidget(context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: AppSize.s160.h,
        alignment: Alignment.topLeft,
        margin: EdgeInsets.symmetric(
            horizontal: AppMargin.m10.w, vertical: AppMargin.m10.h),
        padding: EdgeInsets.symmetric(
            vertical: AppPadding.p20.h, horizontal: AppPadding.p20.w),
        decoration: BoxDecoration(
          color: ColorManager.grey,
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s50.sp)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _checkoutButton(),
            _totalPrice(context),
          ],
        ),
      ),
    );
  }

  Widget _totalPrice(context) {
    double? totalPrice = BlocProvider.of<CartBloc>(context).totalPrice;
    return Text(
      '\$${totalPrice!.round()}',
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  Widget _checkoutButton() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorManager.white),
        borderRadius: BorderRadius.circular(AppSize.s30),
      ),
      child: ElevatedButton(
        onPressed: () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(right: AppPadding.p10.w),
              child: Text(
                AppStrings.checkout.toUpperCase(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const Icon(Icons.arrow_circle_right_sharp),
          ],
        ),
      ),
    );
  }

  Widget _buildCartList(List<CartProductModel> cartItems) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        ProductModel product = cartItems[index].product;
        return _cartItem(index, cartItems, product, context);
      },
    );
  }

  void _onDeleteCartItemErrorState(state, context) {
    if (state is DeleteCartItemErrorState) {
      Fluttertoast.showToast(
        msg: state.message,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorManager.red,
        textColor: ColorManager.white,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  void _onDeleteCartItemSuccessState(state, context) async {
    if (state is DeleteCartItemSuccessState) {
      await Future.delayed(const Duration(milliseconds: 1173));
      BlocProvider.of<CartBloc>(context).add(GetCartEvent());
    }
  }

  void _onUpdateCartItemQuantitySuccessState(state, context) async {
    if (state is UpdateProductQuantityInCartSuccessState) {
      await Future.delayed(const Duration(milliseconds: 1173));
      BlocProvider.of<CartBloc>(context).add(GetCartEvent());
    }
  }

  void _onUpdateCartItemQuantityErrorState(state, context) {
    if (state is UpdateProductQuantityInCartErrorState) {
      Fluttertoast.showToast(
        msg: state.message,
        backgroundColor: ColorManager.red,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  Widget _cartItem(index, cartItems, product, context) {
    return Column(
      children: [
        _itemData(index, cartItems, product, context),
        if (index == cartItems.length - 1)
          SizedBox(
            height: AppSize.s200.h,
          )
      ],
    );
  }

  Widget _itemData(index, cartItems, product, context) {
    return Stack(
      children: [
        _productInformation(index, cartItems, product, context),
        _cartItemImage(product),
      ],
    );
  }

  Widget _productInformation(index, cartItems, product, context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Container(
        height: 200,
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.blueGrey.withOpacity(.3),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _productNameDescriptionPriceQuantity(
                index, cartItems, product, context),
            const Spacer(),
            _deleteButton(index, cartItems, context),
          ],
        ),
      ),
    );
  }

  Widget _productNameDescriptionPriceQuantity(
      index, List<CartProductModel> cartItems, product, context) {
    return Expanded(
      flex: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: StyleManager.titleStyle.copyWith(color: ColorManager.black),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            product.description,
            style: StyleManager.bodyStyle.copyWith(color: Colors.black54),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Text(
                "\$${product.price.round().toString()}",
                style: StyleManager.bodyStyle
                    .copyWith(color: Colors.black, fontSize: FontSize.s12),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                width: 20,
              ),
              if (product.discount != 0)
                Text(
                  "\$${product.oldPrice.round().toString()}",
                  style: StyleManager.bodyStyle.copyWith(
                      color: Colors.red,
                      decoration: TextDecoration.lineThrough,
                      fontSize: FontSize.s12),
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
          _productQuantityManager(index, cartItems, context),
        ],
      ),
    );
  }

  Widget _productQuantityManager(index, cartItems, context) {
    bool isLoading = BlocProvider.of<UpdateProductQuantityInCartBloc>(context)
        .isUpdateCartProductLoading[cartItems[index].cartId]
        .orFalse();

    return Row(
      children: [
        _quantityMangeButton(
          index,
          cartItems,
          context,
          isIncrement: false,
          onTap: () {
            _decrementOnTap(index, cartItems, context);
          },
        ),
        isLoading
            ? SizedBox(
                height: 30,
                width: 30,
                child: Lottie.asset(JsonAssets.loading),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
                child: Text(cartItems[index].quantity.toString()),
              ),
        _quantityMangeButton(
          index,
          cartItems,
          context,
          isIncrement: true,
          onTap: () {
            _incrementOnTap(index, cartItems, context);
          },
        ),
      ],
    );
  }

  Widget _cartItemImage(product) {
    return Positioned(
      bottom: 0,
      right: 15,
      child: Container(
        height: 130,
        width: 130,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: FadeInImage.assetNetwork(
          placeholder: ImagesAssets.imageLoading,
          image: product.image,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _deleteButton(index, cartItems, context) {
    bool isLoading = BlocProvider.of<DeleteCartItemBloc>(context)
        .isCartProductLoading[cartItems[index].cartId]
        .orFalse();

    return isLoading
        ? SizedBox(
            height: 30,
            width: 30,
            child: Lottie.asset(JsonAssets.loading),
          )
        : GestureDetector(
            onTap: () {
              BlocProvider.of<DeleteCartItemBloc>(context)
                  .add(PostDeleteCartItemEvent(cartItems[index].cartId));
            },
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).primaryColor,
                    ],
                  ),
                  shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Icon(
                FontAwesomeIcons.xmark,
                size: 15,
                color: ColorManager.white,
              ),
            ),
          );
  }

  Widget _quantityMangeButton(index, cartItems, context,
      {required bool isIncrement, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).primaryColor,
              ],
            ),
            shape: BoxShape.circle),
        alignment: Alignment.center,
        child: Icon(
          isIncrement ? FontAwesomeIcons.plus : FontAwesomeIcons.minus,
          size: 15,
          color: ColorManager.white,
        ),
      ),
    );
  }

  void _decrementOnTap(index, cartItems, context) {
    counter = cartItems[index].quantity;
    if (counter > 1) {
      counter = cartItems[index].quantity;
      final int quantity = --counter;
      BlocProvider.of<UpdateProductQuantityInCartBloc>(context).add(
          PostUpdateProductQuantityInCartEvent(
              cartItems[index].cartId, quantity));
    }
  }

  void _incrementOnTap(index, cartItems, context) {
    counter = cartItems[index].quantity;
    final int quantity = ++counter;
    BlocProvider.of<UpdateProductQuantityInCartBloc>(context).add(
        PostUpdateProductQuantityInCartEvent(
            cartItems[index].cartId, quantity));
  }

  Widget _errorGetCart(state, context) {
    return ErrorState(StateRendererType.fullScreenErrorState, state.message)
        .getScreenWidget(context, buttonTitle: AppStrings.retryAgain,
            retryActionFunction: () {
      BlocProvider.of<CartBloc>(context).add(GetCartEvent());
    });
  }

  Widget _emptyCart() {
    return Center(
      child: Text(
        'No Cart Items',
        style: StyleManager.titleStyle.copyWith(color: Colors.black),
      ),
    );
  }

  Widget _loadingGetCart(context) {
    return LoadingState(
            stateRendererType: StateRendererType.fullScreenLoadingState)
        .getScreenWidget(context);
  }
}
