import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_project/data/grocery_data.dart';
import 'package:bloc_project/features/home/models/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvenet>(homeInitialEvenet);
    on<HomeProductWishListButtonClickedEvent>(
        homeProductWishListButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
    on<HomeWishListNavigateEvent>(homeWishListNavigateEvent);
  }

  FutureOr<void> homeInitialEvenet(
      HomeInitialEvenet event, Emitter<HomeState> emit) async  {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    emit(HomeLoadedSuccessState(
        products: GrocerryData.groceryProducts
            .map((e) => ProductDataModel(
                id: e['id'],
                name: e['name'],
                description: e['description'],
                price: double.parse(e['price']),
                imageUrl: e['imageUrl']))
            .toList()));
  }

  FutureOr<void> homeProductWishListButtonClickedEvent(
      HomeProductWishListButtonClickedEvent event, Emitter<HomeState> emit) {
    print('WishList Product Clicked');
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print('Cart Product Clicked');
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('Cart Navigate  Clicked');
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> homeWishListNavigateEvent(
      HomeWishListNavigateEvent event, Emitter<HomeState> emit) {
    print('Wish Navigate Clicked');
    emit(HomeNavigateToWishListPageActionState());
  }
}
