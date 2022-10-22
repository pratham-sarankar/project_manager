import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_manager/app/data/repositories/user_repository.dart';

class Project {
  String name;
  Timestamp? deadline;
  String description;
  String priority;
  String status;
  String? userId;

  Project({
    this.name = '',
    this.deadline,
    this.description = '',
    this.priority = 'Unknown',
    this.status = 'Unknown',
    this.userId,
  }) {
    userId = UserRepository.instance.currentUser?.uid;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'deadline': deadline,
      'description': description,
      'priority': priority,
      'status': status,
      'userId': userId,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      name: map['name'],
      deadline: map['deadline'],
      description: map['description'],
      priority: map['priority'],
      status: map['status'],
      userId: map['userId'],
    );
  }

  @override
  String toString() {
    return 'Project{name: $name, deadline: $deadline, description: $description, priority: $priority, status: $status, userId: $userId}';
  }
}
