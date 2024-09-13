import 'dart:convert';

import 'package:cristimer/core/generic/serializer.dart';

abstract class Entity<T> extends Serializer<T> {
  String toJson() {
    return jsonEncode(toMap());
  }
}
