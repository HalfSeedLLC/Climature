import 'package:hive/hive.dart';

class User extends HiveObject {
  String favoriteCity;

  List<String> favorites;

  User(this.favoriteCity, this.favorites);
}

class UserAdapter extends TypeAdapter<User> {
  @override
  final typeId = 0;

  @override
  User read(BinaryReader reader) {
    return User(reader.read(), reader.read())..favorites = reader.read();
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer.write(obj.favoriteCity);
    writer.write(obj.favorites);
  }
}
