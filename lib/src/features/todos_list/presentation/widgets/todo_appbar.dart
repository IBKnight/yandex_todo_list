import 'package:flutter/material.dart';
import 'package:yandex_todo_list/src/core/localization/gen/app_localizations.dart';
import '../../../../common/palette.dart';

class TodoSliverPersistentDelegate extends SliverPersistentHeaderDelegate {
  final int completedCount;
  final VoidCallback showCompleted;
  final bool shownCompleted;

  TodoSliverPersistentDelegate({
    required this.showCompleted,
    required this.completedCount,
    required this.shownCompleted,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final strings = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final progress = shrinkOffset / maxExtent;

    final appBarShadowDecoration = BoxDecoration(
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
    );

    return Container(
      decoration: const BoxDecoration(
        color: Palette.backPrimaryLight,
      ).lerpTo(
        appBarShadowDecoration,
        progress,
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 60),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                '${strings.completed} $completedCount',
                style: TextStyle.lerp(
                  theme.textTheme.bodyLarge
                      ?.copyWith(color: Palette.labelTertiaryLight),
                  theme.textTheme.bodyLarge
                      ?.copyWith(color: Colors.transparent),
                  progress,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.lerp(
                  const EdgeInsetsDirectional.only(end: 24.98),
                  const EdgeInsetsDirectional.only(end: 18, bottom: 16),
                  progress,
                ) ??
                EdgeInsetsDirectional.zero,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Material(
                shape: const CircleBorder(),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    showCompleted();
                  },
                  child: Icon(
                    shownCompleted ? Icons.visibility : Icons.visibility_off,
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
                  progress,
                ) ??
                EdgeInsetsDirectional.zero,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                strings.myTodos,
                style: TextStyle.lerp(
                  theme.textTheme.titleLarge,
                  theme.textTheme.titleMedium,
                  progress,
                ),
              ),
            ),
          ),
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
