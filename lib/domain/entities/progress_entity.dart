import 'package:equatable/equatable.dart';

class ProgressEntity extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String timestamp;
  final String type;

  const ProgressEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.timestamp,
    required this.type,
  });

  @override
  List<Object?> get props => [id, title, subtitle, timestamp, type];
}
