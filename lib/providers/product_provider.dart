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

  List<IndividualFilterModel> selectedBrands = [];
  List<String> selectedDiscounts = [];
  List<String?> selectedSizes = [];
  List<String?> selectedPrices = [];
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
    productsList = await getFilterProductList();
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
  }

  Future<List<ProductModel>> getFilterProductList() async {
    List<ProductModel> getProdList = await services.getFirestoreData();
    // log("selectedBrands:$selectedBrands");
    if (selectedBrands.isNotEmpty) {
      List<ProductModel> _list =
          getAppLiedFilterList(selectedBrands, getProdList);
      // print('---$_list');
      if (_list.isNotEmpty) {
        getProdList = _list;
      }
    }
    return getProdList;
  }

  getAppLiedFilterList(
    List<IndividualFilterModel> selectedFilters,
    List<ProductModel> originalData,
  ) {
    List<ProductModel> productModelList = [];
    productModelList.clear();
    for (var individualFilterModel in selectedFilters) {
      log("individualFilterName: ${individualFilterModel.individualFilterName}");
      for (var product in originalData) {
        if (product.brand == individualFilterModel.individualFilterName) {
          log("product: ${product.brand}");
        }
      }
    }
    // log("selectedFilter: $selectedFilter");

    // for (var individualFilterModel in selectedFilters) {
    //   log("individualFilterName: ${individualFilterModel.individualFilterName}");
    //   for (var i = 0; i < originalData.length; i++) {
    //     log("==${originalData.length}");
    //     productModelList.clear();
    //     if (originalData[i].brand.toLowerCase() ==
    //         individualFilterModel.individualFilterName.toLowerCase()) {
    //       log("brand: ${originalData[i].brand.toLowerCase()} filter: ${individualFilterModel.individualFilterName.toLowerCase()}");

    //       productModelList.add(originalData[i]);
    //       notifyListeners();
    //     }
    // }
    // productModelList = originalData.where((product) {
    //   // log("filter: ${filter.individualFilterName.toLowerCase()} brand: ${product.brand.toLowerCase()}");
    //   return product.brand.toLowerCase() ==
    //       filter.individualFilterName.toLowerCase();
    // }).map((e) {
    //   log(e.brand);
    //   return e;
    // }).toList();

    // log("productModelList: ${productModelList.toList()}");
    // if (isSelected) {
    //   // productModelList.add(filter);
    // }
    // }
    log("productModelList: ${productModelList.length}");
    return productModelList;
  }

  onFilterSubmitEEvent() {
    // TODO: get individual fileter items

    List<IndividualFilterModel> brandFilterModel = filterModelList
        .firstWhere((element) => element.filterName == "brand")
        .filterItems;
    List<IndividualFilterModel> priceFilterModel = filterModelList
        .firstWhere((element) => element.filterName == "size")
        .filterItems;
    List<IndividualFilterModel> discountFilterModel = filterModelList
        .firstWhere((element) => element.filterName == "discount")
        .filterItems;
    List<IndividualFilterModel> sizeFilterModel = filterModelList
        .firstWhere((element) => element.filterName == "price")
        .filterItems;

    selectedBrands.clear();
    for (var item in brandFilterModel) {
      if (item.isSelected) {
        selectedBrands.add(item);
      }
    }
    log("selectedBrands:$selectedBrands");
    notifyListeners();
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

  getFilteredList() async {
    showLoading = true;

    showLoading = false;

    notifyListeners();
  }
}
