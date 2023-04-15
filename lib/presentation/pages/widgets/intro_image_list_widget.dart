import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/presentation/resources/values_manager.dart';

class ImageListView extends StatefulWidget {
  final int startIndex;
  const ImageListView({Key? key, required this.startIndex}) : super(key: key);

  @override
  State<ImageListView> createState() => _ImageListViewState();
}

class _ImageListViewState extends State<ImageListView> {
  final ScrollController _scrollController = ScrollController();
  final List<IntroViewProduct> products = [
    const IntroViewProduct(
      productName: "MNML - Oversized Tshirt",
      productImageUrl:
      "https://images.unsplash.com/photo-1588117305388-c2631a279f82?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1974&q=80",
      currentPrice: "500",
      oldPrice: "700",
      isLiked: true,
    ),
    const IntroViewProduct(
      productName: "Crop Top Hoddie",
      productImageUrl:
      "https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=720&q=80",
      currentPrice: "392",
      oldPrice: "400",
      isLiked: false,
    ),
    const IntroViewProduct(
      productName: "Half Tshirt",
      productImageUrl:
      "https://images.unsplash.com/photo-1529139574466-a303027c1d8b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
      currentPrice: "204",
      oldPrice: "350",
      isLiked: true,
    ),
    const IntroViewProduct(
      productName: "Best Fit Women Outfit",
      productImageUrl:
      "https://images.unsplash.com/photo-1581044777550-4cfa60707c03?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=686&q=80",
      currentPrice: "540",
      oldPrice: "890",
      isLiked: true,
    ),
    const IntroViewProduct(
      productName: "Strip Tourser",
      productImageUrl:
      "https://images.unsplash.com/photo-1509631179647-0177331693ae?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=688&q=80",
      currentPrice: "230",
      oldPrice: "750",
      isLiked: false,
    ),
    const IntroViewProduct(
      productName: "MNML - Jeans",
      productImageUrl:
      "https://images.unsplash.com/photo-1541099649105-f69ad21f3246?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
      currentPrice: "240",
      oldPrice: "489",
      isLiked: false,
    ),
    const IntroViewProduct(
      productName: "MNML - Jeans",
      productImageUrl:
      "https://images.unsplash.com/photo-1475178626620-a4d074967452?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=686&q=80",
      currentPrice: "240",
      oldPrice: "489",
      isLiked: false,
    ),
    const IntroViewProduct(
      productName: "Half Tshirt",
      productImageUrl:
      "https://images.unsplash.com/photo-1517298257259-f72ccd2db392?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=685&q=80",
      currentPrice: "204",
      oldPrice: "350",
      isLiked: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startScrolling();
  }

  void _startScrolling(){
    Future.delayed(const Duration(seconds: 5),() {

      _scrollController.addListener(() {
        if (!_scrollController.position.atEdge) {
          // implement scroll of list
          _autoScroll();
        }
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _autoScroll();
      });
    },);
  }

  void _autoScroll() {
    double currentScrollPosition = _scrollController.offset;
    double scrollEndPosition = _scrollController.position.maxScrollExtent;
    scheduleMicrotask(() {
      _scrollController.animateTo(
          currentScrollPosition == scrollEndPosition ? 0 : scrollEndPosition,
          duration: Duration(seconds: products.length * 3),
          curve: Curves.linear);
    });
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Transform.rotate(
      angle: 1.96 * pi,
      child: SizedBox(
        height: size.height * 0.60,
        width: size.width * 0.60,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: 5,
          itemBuilder: (context, index) => _buildImageItem(size,index),
        ),
      ),
    );
  }

  Widget _buildImageItem(Size size,int index) {
    return CachedNetworkImage(
      imageUrl: products[widget.startIndex + index].productImageUrl,
      imageBuilder: (context, imageProvider) {
        return Container(
          margin: EdgeInsets.only(
            right: AppMargin.m8.w,
            left: AppMargin.m8.w,
            top: AppMargin.m10.h,
          ),
          height: size.height * 0.40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s20),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}