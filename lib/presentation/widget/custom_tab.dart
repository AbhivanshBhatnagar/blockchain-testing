import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomTab extends ConsumerWidget {
  const CustomTab({required this.tabController, this.tabs, super.key});
  final TabController tabController;
  final List<String>? tabs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      child: Container(
        color: Colors.black,
        height: 50,
        child: TabBar(
          enableFeedback: false,
          isScrollable: false,
          splashFactory: NoSplash.splashFactory,
          automaticIndicatorColorAdjustment: true,
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelStyle: const TextStyle(color: Colors.black54),
          controller: tabController,
          indicatorColor: const Color(0xFF338BAA),
          tabs: tabs!
              .map((e) => Tab(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        e,
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: Color(0xFFFEFEFF),
                            ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
