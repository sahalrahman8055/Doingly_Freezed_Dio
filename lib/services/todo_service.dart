import 'package:dio/dio.dart';
import '../model/todo_model.dart';

class TodoServices {
  final Dio dio = Dio();

  Future<List<TodoModel>> getTodo() async {
    const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final json = response.data as Map<String, dynamic>;
        final result = json['items'] as List;
        return result.map((json) => TodoModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch todo');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> submitData(TodoModel requestModel) async {
    final body = requestModel.toJson();
    const url = "https://api.nstack.in/v1/todos";
    try {
      final response = await dio.post(
        url,
        data: body,
        options: Options(contentType: Headers.jsonContentType),
      );
      if (response.statusCode == 201) {
        print('Creation success');
      } else {
        print('Creation failed');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> deleteById(String id) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    try {
      final response = await dio.delete(url);
      if (response.statusCode == 200) {
        print('Delete success');
      } else {
        print('Delete failed');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> updateData(TodoModel requestModel, id) async {
    final body = requestModel.toJson();
    final url = "https://api.nstack.in/v1/todos/$id";
    try {
      final response = await dio.put(
        url,
        data: body,
        options: Options(contentType: Headers.jsonContentType),
      );
      if (response.statusCode == 200) {
        print('Updation success');
      } else {
        print('Updation failed');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
