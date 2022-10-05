import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  MyWidget({
    Key? key,
    required this.onChange,
    required this.index,
    required this.children,
  }) : super(key: key) {
    if (children.length > 5) {
      throw Exception('Too many argyments! 5 at most');
    }
  }

  final int index;
  final ValueChanged<int> onChange;
  final List<String> children;

  @override
  Widget build(BuildContext context) {
    final color = Colors.grey.withAlpha(50);
    final shape = RoundedRectangleBorder(
      side: BorderSide(color: color),
      borderRadius: BorderRadius.circular(8),
    );

    return ClipPath(
      clipper: ShapeBorderClipper(shape: shape),
      child: Container(
        foregroundDecoration: ShapeDecoration(shape: shape),
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [..._buildChildren(context, shape)],
          ),
        ),
      ),
    );
  }

  Iterable<Widget> _buildChildren(
      BuildContext context, RoundedRectangleBorder shape) sync* {
    final theme = Theme.of(context);
    final color1 = theme.primaryColor;
    final color2 = Colors.grey.withAlpha(50);
    final textColor = theme.textTheme.button?.color;
    final style1 = theme.textTheme.button!.copyWith(color: color1);
    final style2 = theme.textTheme.button!.copyWith(color: textColor);

    BorderRadius makeBorderRadius(int index, double radius) {
      if (index == 0) {
        return BorderRadius.only(
          topLeft: Radius.circular(radius),
          bottomLeft: Radius.circular(radius),
        );
      } else if (index == children.length - 1) {
        return BorderRadius.only(
          topRight: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        );
      }
      return BorderRadius.zero;
    }

    double getTextScale() {
      if (children.length == 4) {
        return 0.7;
      } else if (children.length == 5) {
        return 0.5;
      }
      return 1;
    }

    for (int i = 0; i < children.length; i++) {
      final selected = i == index;

      yield InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: makeBorderRadius(i, 8.0),
        ),
        onTap: () {
          onChange(i);
        },
        child: Container(
          foregroundDecoration: BoxDecoration(
            border: Border.all(color: selected ? color1 : color2),
            borderRadius: makeBorderRadius(i, 8.0),
          ),
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: DefaultTextStyle(
            style: selected ? style1 : style2,
            child: Text(
              children[i],
              // Если увеличивать количество элементов - то прийдётся уменьшать скейл текста каждого элемента
              textScaleFactor: getTextScale(),
            ),
          ),
        ),
      );
    }
  }
}
