import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_manager/app/data/models/task.dart';

class TaskProvider {
  final String collectionName;

  TaskProvider({required this.collectionName});

  Stream<QuerySnapshot<Task>> streamAll() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection(collectionName)
        .where('userId', isEqualTo: uid)
        .withConverter<Task>(
      fromFirestore: (snapshot, options) {
        return Task.fromMap(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toMap();
      },
    ).snapshots();
  }

  Stream<QuerySnapshot<Task>> streamAllByProjectId(String id) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection(collectionName)
        .where('userId', isEqualTo: uid)
        .where('projectId', isEqualTo: id)
        .withConverter<Task>(
      fromFirestore: (snapshot, options) {
        return Task.fromMap(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toMap();
      },
    ).snapshots();
  }

  Stream<QuerySnapshot<Task>> streamByProject(String id) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection(collectionName)
        .where('userId', isEqualTo: uid)
        .where('projectId', isEqualTo: id)
        .withConverter<Task>(
      fromFirestore: (snapshot, options) {
        return Task.fromMap(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toMap();
      },
    ).snapshots();
  }

  Stream<List<String>> streamAllStatuses() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection(collectionName)
        .where('userId', isEqualTo: uid)
        .snapshots()
        .map<List<String>>(
          (event) => [
            ...{
              ...event.docs.map((e) {
                return Task.fromMap(e.data()).status;
              }).toList()
            }
          ],
        );
  }

  Stream<List<String>> streamAllPriorities() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection(collectionName)
        .where('userId', isEqualTo: uid)
        .snapshots()
        .map<List<String>>(
          (event) => [
            ...{
              ...event.docs.map((e) {
                return Task.fromMap(e.data()).priority;
              }).toList()
            }
          ],
        );
  }

  Stream<List<String>> streamAllProgresses() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection(collectionName)
        .where('userId', isEqualTo: uid)
        .snapshots()
        .map<List<String>>(
          (event) => [
            ...{
              ...event.docs.map((e) {
                return Task.fromMap(e.data()).progress;
              }).toList()
            }
          ],
        );
  }

  Future<void> insertOne(Task task) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .add(task.toMap());
    return;
  }

  Future<void> onProjectDelete(String id) async {
    final instance = FirebaseFirestore.instance;
    var batch = instance.batch();
    var collection =
        instance.collection(collectionName).where('projectId', isEqualTo: id);
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }

  Future<void> deleteById(String id) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(id)
        .delete();
    return;
  }

  Future<List<String>> fetchAllStatuses() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(collectionName)
        .where('userId', isEqualTo: uid)
        .get();
    return [
      ...{
        ...snapshot.docs.map((e) {
          return Task.fromMap(e.data()).status;
        }).toList()
      }
    ];
  }

  Future<List<String>> fetchAllPriorities() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(collectionName)
        .where('userId', isEqualTo: uid)
        .get();
    return [
      ...{
        ...snapshot.docs.map((e) {
          return Task.fromMap(e.data()).priority;
        }).toList()
      }
    ];
  }

  Future<void> updateById(Task task, String id) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(id)
        .set(task.toMap());
    return;
  }
}
