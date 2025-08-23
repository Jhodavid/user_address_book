abstract class Mapper<T> {
  T fromMap(Map<String, dynamic> map);
  Map<String, dynamic> toMap(T value);
}