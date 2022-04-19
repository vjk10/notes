import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../data/data.dart';

class MyMaterialTextSelectionControls extends MaterialTextSelectionControls {
  // Padding between the toolbar and the anchor.
  static const double _kToolbarContentDistanceBelow = 10.0;
  static const double _kToolbarContentDistance = 8.0;

  /// Builder for material-style copy/paste text selection toolbar.
  @override
  Widget buildToolbar(
    BuildContext context,
    Rect globalEditableRegion,
    double textLineHeight,
    Offset selectionMidpoint,
    List<TextSelectionPoint> endpoints,
    TextSelectionDelegate delegate,
    ClipboardStatusNotifier clipboardStatus,
    Offset? lastSecondaryTapDownPosition,
  ) {
    final TextSelectionPoint startTextSelectionPoint = endpoints[0];
    final TextSelectionPoint endTextSelectionPoint =
        endpoints.length > 1 ? endpoints[1] : endpoints[0];
    final Offset anchorAbove = Offset(
      globalEditableRegion.left + selectionMidpoint.dx,
      globalEditableRegion.top +
          startTextSelectionPoint.point.dy -
          textLineHeight -
          _kToolbarContentDistance,
    );
    final Offset anchorBelow = Offset(
      globalEditableRegion.left + selectionMidpoint.dx,
      globalEditableRegion.top +
          endTextSelectionPoint.point.dy +
          _kToolbarContentDistanceBelow,
    );
    final value = delegate.textEditingValue;
    return MyTextSelectionToolbar(
      anchorAbove: anchorAbove,
      anchorBelow: anchorBelow,
      clipboardStatus: clipboardStatus,
      handleCustomButton: () {
        if (kDebugMode) {
          print(value.selection.textInside(value.text));
        }
        delegate.hideToolbar();
      },
    );
  }
}

class MyTextSelectionToolbar extends StatelessWidget {
  const MyTextSelectionToolbar({
    Key? key,
    required this.anchorAbove,
    required this.anchorBelow,
    required this.clipboardStatus,
    required this.handleCustomButton,
  }) : super(key: key);

  final Offset anchorAbove;
  final Offset anchorBelow;
  final ClipboardStatusNotifier clipboardStatus;
  final VoidCallback? handleCustomButton;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));

    final List<_TextSelectionToolbarItemData> items =
        <_TextSelectionToolbarItemData>[
      _TextSelectionToolbarItemData(
        onPressed: () {},
        label: 'Copy',
      ),
      _TextSelectionToolbarItemData(
        onPressed: () {},
        label: 'Cut',
      ),
      _TextSelectionToolbarItemData(
        onPressed: () {},
        label: 'Copy',
      ),
    ];

    int childIndex = 0;
    return TextSelectionToolbar(
      anchorAbove: anchorAbove,
      anchorBelow: anchorBelow,
      toolbarBuilder: (BuildContext context, Widget child) => Container(
          decoration: BoxDecoration(
            color: c.secondaryContainer,
            borderRadius: BorderRadius.circular(25),
          ),
          child: child),
      children: items
          .map((_TextSelectionToolbarItemData itemData) =>
              TextSelectionToolbarTextButton(
                padding: TextSelectionToolbarTextButton.getPadding(
                    childIndex++, items.length),
                onPressed: itemData.onPressed,
                child: Text(
                  itemData.label,
                  style: t.textTheme.bodySmall?.copyWith(
                    color: c.onSecondaryContainer,
                  ),
                ),
              ))
          .toList(),
    );
  }
}

class _TextSelectionToolbarItemData {
  const _TextSelectionToolbarItemData({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;
}
