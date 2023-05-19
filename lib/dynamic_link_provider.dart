import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkProvider {
  void creatLink(String refCode) async {
    final String url = "https://com.example.flutter_application_1$refCode";

    final DynamicLinkParameters _params = new DynamicLinkParameters(
        link: Uri.parse(url), uriPrefix: "https://sldout.page.link");
  }
}
