import 'package:bloc_project/features/home/bloc/home_bloc.dart';
import 'package:bloc_project/features/home/models/home_product_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  //final HomeBloc homeBloc;
  const ProductTileWidget({super.key, required this.productDataModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(productDataModel.imageUrl))),
          ),
        ],
      ),
    );
  }
}
