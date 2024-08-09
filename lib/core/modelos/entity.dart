import 'dart:convert';

import 'package:funcional_timer_app/core/generic/serializer.dart';

abstract class Entity<T> extends Serializer<T> {
  String toJson() {
    return jsonEncode(toMap());
  }
}
