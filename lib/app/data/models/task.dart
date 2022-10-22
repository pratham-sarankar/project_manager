import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_manager/app/data/repositories/user_repository.dart';

class Task {
  String title;
  String description;
  Timestamp? startDate;
  Timestamp? endDate;
  String status;
  String progress;
  String priority;
  String? userId;
  String? projectId;

  Task({
    this.title = "",
    this.description = "",
    this.status = "",
    this.progress = "",
    this.priority = '',
    this.startDate,
    this.endDate,
    this.userId,
    this.projectId,
  }) {
    userId = UserRepository.instance.currentUser?.uid;
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'startDate': startDate,
      'priority': priority,
      'endDate': endDate,
      'status': status,
      'progress': progress,
      'userId': userId,
      'projectId': projectId,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      description: map['description'],
      startDate: map['startDate'],
      endDate: map['endDate'],
      status: map['status'],
      progress: map['progress'],
      userId: map['userId'],
      projectId: map['projectId'],
      priority: map['priority'],
    );
  }

  @override
  String toString() {
    return 'Task{title: $title, description: $description, startDate: $startDate, endDate: $endDate, status: $status, progress: $progress, priority: $priority, userId: $userId, projectId: $projectId}';
  }
}
