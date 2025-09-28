import 'package:ballaghny/core/utils/constants.dart';
import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/utils/app_strings.dart';

abstract class AboutAppRemoteDataSource {
  Future<String> getContentOfAboutApp();
}

class AboutAppRemoteDataSourceImpl implements AboutAppRemoteDataSource {
  final ApiConsumer apiConsumer;
  AboutAppRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<String> getContentOfAboutApp() async {
    final response = await apiConsumer.get(
      EndPoints.aboutUs,
    );
    final responseJson = Constants.decodeJson(response);
    return responseJson[AppStrings.pageContent];
  }
}
