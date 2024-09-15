import 'package:http/http.dart' as http;
import 'package:joistictask/models/get_job_model.dart';

class JobsApiService {
  static const String baseUrl =
      'https://jsonplaceholder.typicode.com/albums/1/photos';

  Future<List<GetJobModel>> fetchCompanies() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      return getJobModelFromJson(response.body);
    } else {
      throw Exception('Failed to fetch companies');
    }
  }
}
