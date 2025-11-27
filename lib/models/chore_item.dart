import 'chore_type.dart';

class ChoreItem {
  final String id;
  final String title;
  final int points;
  final ChoreType type;

  ChoreItem({
    required this.id,
    required this.title,
    required this.points,
    required this.type,
  });
}
