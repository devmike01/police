import 'package:police/core/api_client_state.dart';
import 'package:police/core/repository.dart';
import 'package:url_launcher/url_launcher.dart';

class MapRepo extends Repository{

  Future<ApiClient<bool>> openMap(String? address) async {
    if(address ==null)return ApiClient.error("Failed to open map");
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$address';
    final parsedUrl = Uri.parse(googleUrl);
    return getWork(() => launchUrl(parsedUrl));
  }
}