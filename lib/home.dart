import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:testing_connector_html/token_generate.dart';
import 'dart:js' as js;
import 'dart:html' as html;
import './html_view.dart' as ui;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late js.JsObject connector;
  String createdViewId = Random().nextInt(1000).toString();
  late html.IFrameElement element;
  bool isLoading = false;
  @override
  void initState() {
    
    initHtmlReg();
    super.initState();
  }

  initHtmlReg() async {
    js.context["connect_content_to_flutter"] = (js.JsObject content) {
      connector = content;
    };
    var filePath = 'assets/html/tinyEditor.html';
    // var htmlString = await rootBundle.loadString(filePath);

    element = html.IFrameElement()
      ..src = filePath
      // ..srcdoc = htmlString
      // ..id = createdViewId
      ..style.border = 'none';
    // ..onLoad.listen((event) async {
    //   print('LISTENIng');
    //   // if (htmlText != '') {
    //   //   sendMessageToHTML(htmlText, 'value');
    //   // }
    // });

    ui.platformViewRegistry
        .registerViewFactory(createdViewId, (int viewId) => element);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
      isLoading? const Center(child: CircularProgressIndicator(),):Container(
          height: MediaQuery.of(context).size.height / 1.5,
          color: Colors.amber,
          child: HtmlElementView(
            viewType: createdViewId,
            // onPlatformViewCreated: (id) {
            //   // sendMessageToHTML(htmlText);
            //   // element.contentWindow!.postMessage({
            //   //   'id': 'value',
            //   //   'msg': ,
            //   // }, "*");
            // },
          ),
        ),
        ElevatedButton(
            onPressed: () {
              // getMessageFromEditor();
              generate();
            },
            child: Text('as'))
      ],
    );
  }

  void generate() {
    // String credentials = "username:password";
    // Codec<String, String> stringToBase64 = utf8.fuse(base64);
    // String encoded =
    //     stringToBase64.encode(credentials); // dXNlcm5hbWU6cGFzc3dvcmQ=
    String token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJhZG1pbkBtYWQuY28uaWQiLCJuYW1lIjoiQWRtaW4gQWRtaW4iLCJwYXNzd29yZCI6IiQyeSQxMCRobGZBWnRWd0tHTkI2LkU5TFBpT0suaExMUmcxanQ5aUEuWnJvWUVLS2VXdDF1ZHBtTk0uZSIsInJvbGVfaWQiOjEsInJvbGVfbmFtZSI6IkFkbWluaXN0cmF0b3IiLCJyb2xlIjoiQWRtaW5pc3RyYXRvciIsImxhc3RVc2VkIjoxNzEzODQwMDI0LCJleHAiOjE3MTQ0NDQ4MjQsIm1lbnUiOlt7Im1lbnVfaWQiOjEsInBhcmVudF9pZCI6bnVsbCwibWVudV9vcmRlciI6MSwibWVudV9uYW1lIjoiZGFzaGJvYXJkIiwibWVudV91cmwiOiIvZGFzaGJvYXJkIiwibWVudV9kaXNwbGF5IjoiRGFzaGJvYXJkIiwibWVudV9pY29uIjoiaHR0cHM6Ly9pbWcuaWNvbnM4LmNvbS9mbHVlbmN5LXN5c3RlbXMtZmlsbGVkLzQwL3BlcmZvcm1hbmNlLW1hY2Jvb2sucG5nIiwibWVudV9zdGF0dXMiOjF9LHsibWVudV9pZCI6MiwicGFyZW50X2lkIjpudWxsLCJtZW51X29yZGVyIjozLCJtZW51X25hbWUiOiJzZXR0aW5ncyIsIm1lbnVfdXJsIjoiL3NldHRpbmdzIiwibWVudV9kaXNwbGF5IjoiU2V0dGluZ3MiLCJtZW51X2ljb24iOiJodHRwczovL2ltZy5pY29uczguY29tL2lvcy1maWxsZWQvNDAvc2V0dGluZ3MucG5nIiwibWVudV9zdGF0dXMiOjF9LHsibWVudV9pZCI6MywicGFyZW50X2lkIjoyLCJtZW51X29yZGVyIjo0LCJtZW51X25hbWUiOiJzZXJ2aWNlLWNhdGFsb2ciLCJtZW51X3VybCI6Ii9zZXR0aW5ncy9zZXJ2aWNlcy1jYXRhbG9nIiwibWVudV9kaXNwbGF5IjoiU2VydmljZSBDYXRhbG9nIiwibWVudV9pY29uIjoiaHR0cHM6Ly9pbWcuaWNvbnM4LmNvbS9pb3MvNTAvc2VydmljZXMtLXYxLnBuZyIsIm1lbnVfc3RhdHVzIjoxfSx7Im1lbnVfaWQiOjQsInBhcmVudF9pZCI6bnVsbCwibWVudV9vcmRlciI6MiwibWVudV9uYW1lIjoidGlja2V0IiwibWVudV91cmwiOiIvdGlja2V0IiwibWVudV9kaXNwbGF5IjoiVGlja2V0IiwibWVudV9pY29uIjoiaHR0cHM6Ly9pbWcuaWNvbnM4LmNvbS9pb3MtZmlsbGVkLzQwL3RpY2tldC5wbmciLCJtZW51X3N0YXR1cyI6MX0seyJtZW51X2lkIjo1LCJwYXJlbnRfaWQiOjIsIm1lbnVfb3JkZXIiOjksIm1lbnVfbmFtZSI6InVzZXIgbWFuYWdlbWVudCIsIm1lbnVfdXJsIjoiL3NldHRpbmdzL3VzZXItbWFuYWdlbWVudCIsIm1lbnVfZGlzcGxheSI6IlVzZXIgTWFuYWdlbWVudCIsIm1lbnVfaWNvbiI6Imh0dHBzOi8vaW1nLmljb25zOC5jb20vbWF0ZXJpYWwtb3V0bGluZWQvNDgvYWRtaW4tc2V0dGluZ3MtbWFsZS5wbmciLCJtZW51X3N0YXR1cyI6MX0seyJtZW51X2lkIjo2LCJwYXJlbnRfaWQiOm51bGwsIm1lbnVfb3JkZXIiOjQsIm1lbnVfbmFtZSI6InByb2ZpbGUiLCJtZW51X3VybCI6Ii9wcm9maWxlIiwibWVudV9kaXNwbGF5IjoiUHJvZmlsZSIsIm1lbnVfaWNvbiI6Imh0dHBzOi8vaW1nLmljb25zOC5jb20vaW9zLWZpbGxlZC81MC91c2VyLW1hbGUtY2lyY2xlLnBuZyIsIm1lbnVfc3RhdHVzIjoxfSx7Im1lbnVfaWQiOjcsInBhcmVudF9pZCI6MiwibWVudV9vcmRlciI6MSwibWVudV9uYW1lIjoic2V2ZXJpdHkiLCJtZW51X3VybCI6Ii9zZXR0aW5ncy9zZXZlcml0eSIsIm1lbnVfZGlzcGxheSI6IlNldmVyaXR5IiwibWVudV9pY29uIjoiaHR0cHM6Ly9pbWcuaWNvbnM4LmNvbS93aW5kb3dzLzMyL3NldmVyaXR5LnBuZyIsIm1lbnVfc3RhdHVzIjoxfSx7Im1lbnVfaWQiOjgsInBhcmVudF9pZCI6MiwibWVudV9vcmRlciI6MiwibWVudV9uYW1lIjoidGlja2V0IHN0YXR1cyIsIm1lbnVfdXJsIjoiL3NldHRpbmdzL3RpY2tldC1zdGF0dXMiLCJtZW51X2Rpc3BsYXkiOiJUaWNrZXQgU3RhdHVzIiwibWVudV9pY29uIjoiaHR0cHM6Ly9pbWcuaWNvbnM4LmNvbS9tYXRlcmlhbC1vdXRsaW5lZC80OC9vay0tdjEucG5nIiwibWVudV9zdGF0dXMiOjF9LHsibWVudV9pZCI6MTAsInBhcmVudF9pZCI6MiwibWVudV9vcmRlciI6NiwibWVudV9uYW1lIjoiR3JvdXAiLCJtZW51X3VybCI6Ii9zZXR0aW5ncy9ncm91cCIsIm1lbnVfZGlzcGxheSI6Ikdyb3VwIiwibWVudV9pY29uIjoiaHR0cHM6Ly9pbWcuaWNvbnM4LmNvbS9mbHVlbmN5LXN5c3RlbXMtcmVndWxhci80OC9ncm91cC1mb3JlZ3JvdW5kLXNlbGVjdGVkLnBuZyIsIm1lbnVfc3RhdHVzIjoxfSx7Im1lbnVfaWQiOjExLCJwYXJlbnRfaWQiOjIsIm1lbnVfb3JkZXIiOjcsIm1lbnVfbmFtZSI6ImN1c3RvbWVyIG1hbmFnZW1lbnQiLCJtZW51X3VybCI6Ii9zZXR0aW5ncy9jdXN0ZW1lci1tYW5hZ2VtZW50IiwibWVudV9kaXNwbGF5IjoiQ3VzdG9tZXIgTWFuYWdlbWVudCIsIm1lbnVfaWNvbiI6Imh0dHBzOi8vaW1nLmljb25zOC5jb20vaW9zLzEwMC9nZW5kZXItbmV1dHJhbC11c2VyLS12MS5wbmciLCJtZW51X3N0YXR1cyI6MX0seyJtZW51X2lkIjoxNSwicGFyZW50X2lkIjoyLCJtZW51X29yZGVyIjoxMSwibWVudV9uYW1lIjoiZW1haWwiLCJtZW51X3VybCI6Ii9zZXR0aW5ncy9lbWFpbCIsIm1lbnVfZGlzcGxheSI6IkVtYWlsIiwibWVudV9pY29uIjoiaHR0cHM6Ly9pbWcuaWNvbnM4LmNvbS9mbHVlbmN5LXN5c3RlbXMtcmVndWxhci80OC9uZXctcG9zdC5wbmciLCJtZW51X3N0YXR1cyI6MX0seyJtZW51X2lkIjoxNiwicGFyZW50X2lkIjoyLCJtZW51X29yZGVyIjozLCJtZW51X25hbWUiOiJ0aWNrZXQgdHlwZSIsIm1lbnVfdXJsIjoiL3NldHRpbmdzL3RpY2tldC10eXBlIiwibWVudV9kaXNwbGF5IjoiVGlja2V0IFR5cGUiLCJtZW51X2ljb24iOiJodHRwczovL2ltZy5pY29uczguY29tL2lvcy1nbHlwaHMvMzAvaGlnaC1pbXBvcnRhbmNlLnBuZyIsIm1lbnVfc3RhdHVzIjoxfSx7Im1lbnVfaWQiOjE3LCJwYXJlbnRfaWQiOjIsIm1lbnVfb3JkZXIiOjEyLCJtZW51X25hbWUiOiJzZXR0aW5nIHZhcmlhYmxlIiwibWVudV91cmwiOiIvc2V0dGluZ3Mvc2V0dGluZ3MtdmFyaWFibGUiLCJtZW51X2Rpc3BsYXkiOiJTZXR0aW5nIFZhcmlhYmxlIiwibWVudV9pY29uIjoiaHR0cHM6Ly9pbWcuaWNvbnM4LmNvbS9pb3MtZ2x5cGhzLzMwL2hpZ2gtaW1wb3J0YW5jZS5wbmciLCJtZW51X3N0YXR1cyI6MX1dLCJzdGF0dXNfYXBwcm92YWwiOjEsImdyb3VwX3Blcm1pc3Npb25zIjpbeyJhZ2VudF9ncm91cF9pZCI6NywiYWdlbnRfZ3JvdXBfbmFtZSI6IlRlc3QgR3JvdXAiLCJhY2Nlc3NfYXBwcm92YWwiOjEsInNlcnZpY2VfY2F0YWxvZyI6W3siYWdlbnRfZ3JvdXBfc2VydmljZV9jYXRhbG9nX2lkIjo4LCJzZXJ2aWNlX2NhdGFsb2dfaWQiOjF9LHsiYWdlbnRfZ3JvdXBfc2VydmljZV9jYXRhbG9nX2lkIjo5LCJzZXJ2aWNlX2NhdGFsb2dfaWQiOjh9XX1dLCJpYXQiOjE3MTM4NDAwMjR9.1EAdsobMIl7m4IcGf6OmJLZvRLMfT4PdVJq6MCSnpvM';
    // String decoded = stringToBase64.decode(encoded);
    // String decodeToken = stringToBase64.decode(token);
    String normalizedSource = base64Url.normalize(token.split(".")[1]);
    String tokenDecode = utf8.decode(base64Url.decode(normalizedSource));
    Map<String, dynamic> pareseToken = Token().parseJwt(token);
    print('TOKEN ${pareseToken['menu']}');
  }

  void getMessageFromEditor() {
    final dynamic str = connector.callMethod(
      'getValue',
    ) as dynamic;
    print(str);
  }
}
