import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConstants {
  static final String apiBaseUrl = dotenv.env['API_BASE_URL']!;
}
