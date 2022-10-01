class FilterModel {
  String filterName; //string
  List<IndividualFilterModel> filterItems; //List<strings>
  FilterModel({
    required this.filterName,
    required this.filterItems,
  });
}

class IndividualFilterModel {
  String individualFilterName;
  bool isSelected;
  IndividualFilterModel({
    required this.individualFilterName,
    this.isSelected = false,
  });
}

List<Map<String, List<String>>> filters = [
  {
    "brand": ["Roadstar", "Smartess", "U.S Polo", "Puma", "Tripr"],
  },
  {
    "size": ["S", "M", "L", "XL"],
  },
  {
    "price": [
      "₹500 - ₹1000",
      "₹1000 - ₹1500",
      "₹1500 - ₹2000",
      "₹2000 - ₹2500",
      "₹2500 - ₹3000"
    ]
  },
  {
    "discount": ["10%", "20%", "30%", "40%", "50%"],
  }
];
