class ThemeModels {
  final int index;
  final String title;

  ThemeModels({
    required this.index,
    required this.title,
  });
}

List<ThemeModels> themeRadioListTile = [
  ThemeModels(
    index: 0,
    title: "Light",
  ),
  ThemeModels(
    index: 1,
    title: "Dark",
  ),
  ThemeModels(
    index: 2,
    title: "System default",
  ),
];
