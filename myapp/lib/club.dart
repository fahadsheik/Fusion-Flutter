class ClubCategory {
  final String name;
  final List<ClubItem> items;

  ClubCategory({required this.name, required this.items});
}

class ClubItem {
  final String name;
  bool isChecked;

  ClubItem({required this.name, this.isChecked = false});
}