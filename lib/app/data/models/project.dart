import 'package:project_manager/app/data/repositories/user_repository.dart';

class Project {
  String name;
  String? userId;

  Project({
    this.name = '',
    this.userId,
  }) {
    userId = UserRepository.instance.currentUser?.uid;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'userId': userId,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      name: map['name'],
      userId: map['userId'],
    );
  }

  @override
  String toString() {
    return 'Project{name: $name, userId: $userId}';
  }
}
