import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyWebsite extends StatefulWidget {
  final Map<dynamic, dynamic> res;
  const MyWebsite({Key? key, required this.res}) : super(key: key);

  @override
  State<MyWebsite> createState() => _MyWebsiteState();
}

class _MyWebsiteState extends State<MyWebsite> {
  double _progress = 0;
  int _selectedIndex = 0;
  late InAppWebViewController inAppWebViewController;

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async {
        //  var isLastPage = await inAppWebViewController.canGoBack();

        // if (isLastPage) {
        //   inAppWebViewController.goBack();
        //   return false;
        // }

        // return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text('Ayra'), actions: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                      value: 'https://dev.ayra.social/en',
                      child: Text("English")),
                  const PopupMenuItem(
                    value: 'https://dev.ayra.social/hi-IN',
                    child: Text("Hindi"),
                  ),
                  const PopupMenuItem(
                    value: 'https://dev.ayra.social/kn-IN',
                    child: Text("Kanada"),
                  )
                ],
                initialValue: 'https://dev.ayra.social/en',
                onSelected: (value) {
                  setState(() {
                    inAppWebViewController.evaluateJavascript(
                        source: 'location.href="$value"');
                  });
                },
                child: const Icon(Icons.translate),
              ),
            )
          ]),
          body: Stack(
            children: [
              InAppWebView(
                // onConsoleMessage: (controller, consoleMessage) {
                //   print('Console message :${consoleMessage.message}');
                // },
                
                initialUrlRequest:
                    URLRequest(url: WebUri("https://dev.ayra.social/")),
                onWebViewCreated: (InAppWebViewController controller) {
                  inAppWebViewController = controller;

                  // controller.evaluateJavascript(
                  //     source:
                  //         'document.getElementsByTagName("header")[0].style.display="none"');
                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {
                  setState(() {
                    _progress = progress / 100;
                  });
                  print(widget.res['user']['profile']['name']);
                  //print(widget.res["jwt"]);
                  final query = widget.res["user"];
                   controller.evaluateJavascript(
                      source:
                          "window.localStorage.removeItem('user');");
                  controller.evaluateJavascript(
                      source:
                          "window.localStorage.setItem('user', '$query');");
                  controller.evaluateJavascript(
                      source: "console.log(window.localStorage.getItem('user'));");
                  controller.evaluateJavascript(
                      source:
                          'document.getElementsByTagName("header")[0].style.display="none"');
                },
                onPageCommitVisible: (controller, url) {
                  print('New Website: $url');
                },
              ),
              _progress < 1
                  ? Container(
                      child: LinearProgressIndicator(
                        value: _progress,
                      ),
                    )
                  : const SizedBox()
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              // inAppWebViewController.loadUrl(urlRequest: URLRequest(url: WebUri('https://youtube.com')));
              inAppWebViewController.evaluateJavascript(
                  source:
                      'location.href="https://dev.ayra.social/core/write/new"');
            },
            child: const Icon(
              FontAwesomeIcons.pen,
              size: 25,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: IconButton(
                  color: Colors.black,
                  onPressed: () {
                    inAppWebViewController.evaluateJavascript(
                        source: 'location.href="https://dev.ayra.social/"');
                  },
                  icon: const Icon(Icons.home),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: IconButton(
                  color: Colors.black,
                  onPressed: () {
                    inAppWebViewController.evaluateJavascript(
                        source:
                            'location.href="https://dev.ayra.social/core/search"');
                  },
                  icon: const Icon(Icons.search),
                ),
                label: 'Write',
              ),
              BottomNavigationBarItem(
                icon: IconButton(
                  color: Colors.black,
                  onPressed: () {
                    inAppWebViewController.evaluateJavascript(
                        source:
                            'location.href="https://ayra.social/core/search"');
                  },
                  icon: const Icon(Icons.bookmark),
                ),
                label: 'search',
              ),
              BottomNavigationBarItem(
                icon: IconButton(
                  color: Colors.black,
                  onPressed: () {
                    // inAppWebViewController.evaluateJavascript(
                    //     source:
                    //         'localStorage.setItem("user", ${widget.res["user"]});');
                    inAppWebViewController.evaluateJavascript(
                        source:
                            'location.href="https://ayra.social/core/profile/me"');
                  },
                  icon: const Icon(Icons.person),
                ),
                label: 'Profile',
              ),
            ],
            type: BottomNavigationBarType.shifting,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            iconSize: 30,
            onTap: onItemTapped,
          ),
        ),
      ),
    );
  }
}
