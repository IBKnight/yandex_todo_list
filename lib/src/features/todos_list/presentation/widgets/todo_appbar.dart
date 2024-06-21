import 'package:flutter/material.dart';
import 'package:yandex_todo_list/src/common/palette.dart';
import 'package:yandex_todo_list/src/common/strings.dart';

class TodoSliverPersistentDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final progress = shrinkOffset / maxExtent;

    return Container(
      decoration: const BoxDecoration(
        color: Palette.backPrimaryLight,
      ).lerpTo(
          BoxDecoration(
            color: Palette.backPrimaryLight,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 2),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.14),
              ),
              BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 5,
                color: Colors.black.withOpacity(0.12),
              ),
              BoxShadow(
                offset: const Offset(0, 1),
                blurRadius: 10,
                color: Colors.black.withOpacity(0.2),
              ),
            ],
          ),
          progress),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 60),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                Strings.completed,
                style: TextStyle.lerp(
                    Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Palette.labelTertiaryLight),
                    Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.transparent),
                    progress),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.lerp(
                    const EdgeInsetsDirectional.only(end: 24.98),
                    const EdgeInsetsDirectional.only(end: 18, bottom: 16),
                    progress) ??
                const EdgeInsetsDirectional.only(end: 0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Material(
                shape: const CircleBorder(),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {},
                  child: const Icon(
                    Icons.visibility_off,
                    size: 22.03,
                    color: Palette.blueLight,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.lerp(
                    const EdgeInsetsDirectional.only(start: 60, bottom: 28),
                    const EdgeInsetsDirectional.only(start: 16, bottom: 16),
                    progress) ??
                const EdgeInsetsDirectional.only(end: 0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                Strings.myTodos,
                style: TextStyle.lerp(Theme.of(context).textTheme.titleLarge,
                    Theme.of(context).textTheme.titleMedium, progress),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => 164;

  @override
  double get minExtent => 88;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
