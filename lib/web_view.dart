import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HelpCenterWebView extends StatefulWidget {
  const HelpCenterWebView({super.key});

  @override
  State<HelpCenterWebView> createState() => _HelpCenterWebViewState();
}

class _HelpCenterWebViewState extends State<HelpCenterWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            /*
            if (request.url.startsWith('')) {
              //https://www.acnturk.com.tr/urunlerimiz/dort-dortluk-kasko-sigortasi
              //    return NavigationDecision.prevent;
            }
             */
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.youtube.com/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                NavigationControls(webViewController: _controller),
                const Spacer(),
                ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.clear,
                    size: 42,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 8,)
              ],
            ),
            Expanded(
                child: WebViewWidget(
                  controller: _controller,
                )),
          ],
        ),
      ),
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls({super.key, required this.webViewController});

  final WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        /*
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () async {
            if (await webViewController.canGoBack()) {
              await webViewController.goBack();
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No back history item')),
                );
              }
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () async {
            if (await webViewController.canGoForward()) {
              await webViewController.goForward();
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No forward history item')),
                );
              }
            }
          },
        ),
        */
        IconButton(
          icon: const Icon(Icons.replay),
          onPressed: () => webViewController.reload(),
        ),
      ],
    );
  }
}