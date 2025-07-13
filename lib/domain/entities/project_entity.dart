import 'package:equatable/equatable.dart';

class ProjectEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String date;
  final String status;
  final double progress;

  const ProjectEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
    required this.progress,
  });

  @override
  List<Object?> get props => [id, title, description, date, status, progress];
}
