import 'dart:ui';

class ItemModel {
  Color color;

  ItemModel({this.offset, this.text, this.color});

  final Offset offset;
  final String text;

  ItemModel copyWithNewOffset(Offset offset) {
    return ItemModel(offset: offset, text: text, color: color);
  }
}
