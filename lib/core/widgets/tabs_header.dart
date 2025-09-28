import 'package:flutter/material.dart';

class TabsHeader extends SliverPersistentHeaderDelegate {
  TabsHeader({required this.tabs});
  final Widget tabs;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return tabs;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
