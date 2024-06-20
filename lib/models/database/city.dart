import 'package:objectbox/objectbox.dart';

@Entity()
class City {
  City({
    required this.name,
  });

  @Id()
  int id = 0;

  String? name;

  @Property(type: PropertyType.date)
  DateTime? date;

  @Transient()
  int? computedProperty;
}
