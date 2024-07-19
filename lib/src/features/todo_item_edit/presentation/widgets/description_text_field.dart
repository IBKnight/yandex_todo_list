part of 'package:yandex_todo_list/src/features/todo_item_edit/presentation/todo_item_edit_screen.dart';

class _DescriptionTextField extends StatelessWidget {
  const _DescriptionTextField({
    required TextEditingController textEditingController,
  }) : _textEditingController = textEditingController;

  final TextEditingController _textEditingController;

  @override
  Widget build(BuildContext context) {

    final brandColors = Theme.of(context).extension<BrandColors>()!;

    return Container(
      margin: const EdgeInsetsDirectional.symmetric(horizontal: 16),
      constraints: BoxConstraints(
        minHeight: 104,
        minWidth: MediaQuery.of(context).size.width,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Palette.shadowColor.withOpacity(0.06),
          ),
          BoxShadow(
            blurRadius: 2,
            offset: const Offset(0, 2),
            color: Palette.shadowColor.withOpacity(0.12),
          ),
        ],
        color: brandColors.backSecondary,
      ),
      child: TextField(
        controller: _textEditingController,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        style: Theme.of(context).textTheme.bodyLarge,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: AppLocalizations.of(context).whatNeedToDo,
          hintStyle: Theme.of(context).textTheme.bodyLarge,
          contentPadding: const EdgeInsetsDirectional.all(16),
        ),
        keyboardType: TextInputType.multiline,
        minLines: 3,
        maxLines: null,
      ),
    );
  }
}
