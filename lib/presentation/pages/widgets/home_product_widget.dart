import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/presentation/bloc/category_products/category_products_bloc.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:moro_shop/presentation/resources/color_manager.dart';
import 'package:moro_shop/presentation/resources/strings_manager.dart';

class HomeProductWidget extends StatefulWidget {
  final int categoryId;

  const HomeProductWidget({Key? key, required this.categoryId})
      : super(key: key);

  @override
  State<HomeProductWidget> createState() => _HomeProductWidgetState();
}

class _HomeProductWidgetState extends State<HomeProductWidget> {
  @override
  void initState() {
    super.initState();
        BlocProvider.of<CategoryProductsBloc>(context)
            .add(GetCategoryProductsEvent(widget.categoryId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryProductsBloc,CategoryProductsState>(
      listener: (context, state) {
        if(state is GetCategoryProductsErrorState){
          if(state.message == AppStrings.unKnownError) {
            BlocProvider.of<CategoryProductsBloc>(context)
                .add(GetCategoryProductsEvent(widget.categoryId));
          }

        }
      },
      builder: (context, state) {
        if(state is GetCategoryProductsSuccessState) {
          List<ProductModel>? products = state.categoryAllDataModel.categoryAllProductsModel?.products;
          return MasonryGridView.count(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          crossAxisSpacing: 15,
          crossAxisCount: 2,
          itemCount: state.categoryAllDataModel.categoryAllProductsModel?.products?.length ?? 2,
          mainAxisSpacing: 10,
          itemBuilder: (context, index) {
            return singleItemWidget(
              products?[index],
              index == (products?.length ?? 2) - 1 ? true : false,
              index,
            );
          },
        );
        }
        if (state is GetCategoryProductsErrorState){
          return ErrorState(StateRendererType.fullScreenErrorState, state.message).getScreenWidget(context,retryActionFunction: (){
            BlocProvider.of<CategoryProductsBloc>(context).add(GetCategoryProductsEvent(widget.categoryId));
          });
        }
        if(state is GetCategoryProductsLoadingState) {
          return LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState).getScreenWidget(context);
        }

        return LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState).getScreenWidget(context);
      },
    );
  }

  singleItemWidget(ProductModel? product, bool lastItem, int index) {
    return Column(
      children: [
        Stack(
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
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image(
                      image: NetworkImage(
                        product?.image ?? '',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
                    child: Text(
                      product?.name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      children: [
                        Text("\$${product?.price??0}"),
                        const SizedBox(
                          width: 5,
                        ),
                        if(product?.discount!=0)
                          Text(
                          "\$${product?.oldPrice??0}",
                          style: TextStyle(
                            color: ColorManager.grey,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: ColorManager.red,
                            decorationThickness: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 5,
              top: 10,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).primaryColor,
                    ]),
                    // color: ColorManager.primary,
                    shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Icon(
                  FontAwesomeIcons.heartPulse,
                  size: 15,
                  color: ColorManager.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height:
              lastItem == true ? MediaQuery.of(context).size.height * 0.15 : 0,
        )
      ],
    );
  }
}
