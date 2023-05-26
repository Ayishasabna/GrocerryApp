import 'package:bloc_project/features/cart/ui/cart.dart';
import 'package:bloc_project/features/home/bloc/home_bloc.dart';
import 'package:bloc_project/features/home/ui/product_tile_widget.dart';
import 'package:bloc_project/features/wishlist/ui/wishlist.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homebloc.add(HomeInitialEvenet());
    super.initState();
  }

  final HomeBloc homebloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homebloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Cart()));
          /* Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart())); */
        } else if (state is HomeNavigateToWishListPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => WishList()));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );

          case HomeLoadedSuccessState:
            final succesState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.teal,
                title: Center(child: Text('Grocery')),
                actions: [
                  IconButton(
                      onPressed: () {
                        homebloc.add(HomeWishListNavigateEvent());
                      },
                      icon: Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        homebloc.add(HomeCartButtonNavigateEvent());
                      },
                      icon: Icon(Icons.shopping_bag_outlined))
                ],
              ),
              body: ListView.builder(
                  itemCount: succesState.products.length,
                  itemBuilder: (context, index) {
                    return ProductTileWidget(
                      productDataModel: succesState.products[index],
                    );
                  }),
            );

          case HomeErrorState:
            return Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );
          default:
            return SizedBox();
        }
        /*  return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: Center(child: Text('Grocery')),
            actions: [
              IconButton(
                  onPressed: () {
                    homebloc.add(HomeWishListNavigateEvent());
                  },
                  icon: Icon(Icons.favorite_border)),
              IconButton(
                  onPressed: () {
                    homebloc.add(HomeCartButtonNavigateEvent());
                  },
                  icon: Icon(Icons.shopping_bag_outlined))
            ],
          ),
        ); */
      },
    );
  }
}
