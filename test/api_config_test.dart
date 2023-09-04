import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_info/data/api_config.dart';
import 'package:movie_info/general_helpers/config/env.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group('ApiConfig Tests', () {
    late ApiConfig apiConfig;
    late MockDio mockDio;

    setUp(() {
      apiConfig = ApiConfig();
      mockDio = MockDio();
    });
    
    test('getAPI returns response when request is successful', () async {
      String url = '${apiConfig.apiUrlMovie}/123';
      final queryParams = {'language': 'en-US'};
      final headers = {
        "accept": "application/json",
        "Authorization": "Bearer ${Env.apiKey}",
      };
  
      final mockResponse = Response(data: {'title': 'The Lord of the Rings'}, statusCode: 200, requestOptions: RequestOptions(
        method: 'GET',
        baseUrl: url,
      ));

      when(mockDio.get(url, queryParameters: queryParams))
          .thenAnswer((_) async => mockResponse);

      final response = await apiConfig.getAPI(url: url, params: queryParams, headers: headers);

      expect(response.data['title'], 'The Lord of the Rings'); // Compare 'title' fields

      // You can add more assertions here if needed.
    });
  });
}
