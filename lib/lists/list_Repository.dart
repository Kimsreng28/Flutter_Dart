import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:tasklist_backend/hash_extension.dart';

part 'list_Repository.g.dart';

@visibleForTesting
//data source for memory cache
Map<String, TaskList> listDb = {};

@JsonSerializable()
class TaskList extends Equatable {
  //constructor
  const TaskList({required this.id, required this.name});

  //deserialization
  factory TaskList.fromJson(Map<String, dynamic> json) =>
      _$TaskListFromJson(json);

  //copy constructor
  TaskList copyWith({String? id, String? name}) {
    return TaskList(id: id ?? this.id, name: name ?? this.name);
  }

  //properties
  final String id;
  final String name;

  //serialization
  Map<String, dynamic> toJson() => _$TaskListToJson(this);

  //Equatable
  @override
  List<Object> get props => [id, name];
}

//Repositories TaskList
class TaskListRepository {
  //get task list
  Future<TaskList?> listById(String id) async {
    return listDb[id];
  }

  // get all the lists
  Map<String, dynamic> getAllLists() {
    final formattedLists = <String, dynamic>{};

    if (listDb.isNotEmpty) {
      listDb.forEach(
        (String id) {
          final currentList = listDb[id];
          formattedLists[id] = currentList?.toJson();
        } as void Function(String key, TaskList value),
      );
    }

    return formattedLists;
  }

  String createList({required String name}) {
    // dynamically generated id
    final id = name.hashValue;

    //create a new TaskList object
    final list = TaskList(id: id, name: name);

    // add a new TaskList object to the database
    listDb[id] = list;

    return id;
  }

  // Delete a TaskList object with the given id
  void deleteList(String id) {
    listDb.remove(id);
  }

  // Update Operation
  Future<void> updateList({required String id, required String name}) async {
    final currentList = listDb[id];

    if (currentList == null) {
      return Future.error(Exception('List not found'));
    }

    listDb[id] = TaskList(id: id, name: name);
  }
}
