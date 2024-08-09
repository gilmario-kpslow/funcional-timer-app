abstract class Serializer<T> {
  T fromMap(Map<String, dynamic> jsonMap);
  Map<String, dynamic> toMap();
}
