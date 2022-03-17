// ignore_for_file: file_names

import 'package:flutter/material.dart';

class NavBarItemsMoldes {
  final String title;
  final IconData? icon;
  final IconData? unselectedIcons;

  NavBarItemsMoldes({
    required this.title,
    this.icon,
    this.unselectedIcons,
  });
}

List<NavBarItemsMoldes> navBarItemList = [
  NavBarItemsMoldes(
    icon: Icons.home,
    unselectedIcons: Icons.home_outlined,
    title: 'Home',
  ),
  NavBarItemsMoldes(
    unselectedIcons: Icons.search,
    icon: Icons.search_off_outlined,
    title: 'Search',
  ),
  NavBarItemsMoldes(
    icon: Icons.add_box,
    unselectedIcons: Icons.add_box_outlined,
    title: 'upload',
  ),
  NavBarItemsMoldes(
    title: 'account',
  ),
];
