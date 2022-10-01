import 'dart:developer';

import 'package:cloth_app/models/filter_model.dart';
import 'package:cloth_app/models/product_model.dart';
import 'package:cloth_app/services/firestore_services.dart';
import 'package:flutter/foundation.dart';

class ProductProvider extends ChangeNotifier {
  FirestoreServices services = FirestoreServices();

  List<ProductModel> productsList = [];
  List<FilterModel> filterModelList = [];
  List<ProductModel> filterProductsList = [];
  Set<String> individualFilters = {};
  Set<Map<String, Set<String>>> filterList = {};
  bool _showLoading = true;
  bool _isSelected = false;

  bool get isSelected => _isSelected;
  set isSelected(bool value) {
    _isSelected = value;
    notifyListeners();
  }

  bool get showLoading => _showLoading;
  set showLoading(bool value) {
    _showLoading = value;
    notifyListeners();
  }

  init() async {
    productsList = await services.getFirestoreData();
    filterModelList.clear();
    filterProductsList.clear();
    filterModelList = (getInitializeFilterItems());
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 200));
    showLoading = false;
  }

  onChipClicked(
      {required String individualFilterName, required String filterName}) {
    isSelected = !isSelected;
    changeFilterStatus(
        individualFilterName: individualFilterName, filterName: filterName);

    notifyListeners();
    log(filterList.toString());
    // getFilteredList(
    //     filterName: filterName, individualFilterNames: individualFilterNames);

    log("--$individualFilterName-$filterName");
  }

  List<FilterModel> getInitializeFilterItems() {
    List<FilterModel> _filterModeList = List.generate(
      filters.length,
      (index) {
        String filterName = filters[index].keys.first;
        List<String> filterItemList = filters[index].values.first;

        return FilterModel(
            filterName: filterName,
            filterItems: List.generate(filterItemList.length, (idx) {
              return IndividualFilterModel(
                  individualFilterName: filterItemList[idx]);
            }));
      },
    );
    return _filterModeList;
  }

  changeFilterStatus(
      {required String individualFilterName, required String filterName}) {
    for (int i = 0; i < filterModelList.length; i++) {
      if (filterModelList[i].filterName == filterName) {
        List<IndividualFilterModel> _individualFilterItems =
            filterModelList[i].filterItems;

        for (int j = 0; j < _individualFilterItems.length; j++) {
          if (_individualFilterItems[j].individualFilterName ==
              individualFilterName) {
            bool _isSelected = _individualFilterItems[j].isSelected;
            _individualFilterItems[j].isSelected = !(_isSelected);
          }
        }

        filterModelList[i].filterItems = _individualFilterItems;
      }
      notifyListeners();
    }
  }

  List<Map<String, Set<String>>> lists = [
    {
      "discount": {"10%", "20%"},
    },
    {
      "brand": {"Roadstar", "Tripr", "Smartees"},
    },
    // {
    //   "size": {"XL"},
    // }
  ];
  getFilteredList() async {
    services.getList();
    // List<ProductModel> sizeFIlter = [];
    // List<ProductModel> normaFilter = [];
    // showLoading = true;
    // for (int i = 0; i < lists.length; i++) {
    //   for (int j = 0; j < lists[i].keys.length; j++) {
    //     if (lists[i].keys.elementAt(j) == "size") {
    //       sizeFIlter = await services
    //           .getSizeFilterProducts(lists[i].values.elementAt(j).toList());
    //     } else {
    //       normaFilter = await services.getFilterProducts(
    //           lists[i].keys.elementAt(j),
    //           lists[i].values.elementAt(j).toList());
    //     }
    //   }

    //   //   // log(filterProductsList.toString());
    //   showLoading = false;
    // }
    // filterProductsList = normaFilter + sizeFIlter;

    // notifyListeners();

    // log("-${sizeFIlter.length}-${normaFilter.length}");
  }
}
/*

// List wallpaperOpt = [
//     {"key": "HOME SCREEN", "value": 1},
//     {"key": "LOCK SCREEN", "value": 2},
//     {"key": "BOTH SCREEN", "value": 3},
//   ];
 // Map<bool, ProductModel> _wishListProducts = {};
  // List<Map<bool, ProductModel>> _wishList = [];
  // List<Map<bool, ProductModel>> get wishList => _wishList;
  // set wishList(List<Map<bool, ProductModel>> value) {
  //   _wishList = value;
  //   notifyListeners();
  // }
  // Map<bool, ProductModel> get wishListProducts => _wishListProducts;
  // set wishListProducts(Map<bool, ProductModel> value) {
  //   _wishListProducts = value;
  //   notifyListeners();
  // }
  // addedToWishList(bool isWishListed, ProductModel product) {
  //   isWishListed = !isWishListed;
  //   // wishList.add(product);
  //   wishListProducts.addAll({
  //   });
  //   notifyListeners();
  //   log(isWishListed.toString());
  // }
 */