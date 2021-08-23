import 'dart:io';

import 'package:blocnews/blocs/newsbloc/news_bloc.dart';
import 'package:blocnews/blocs/newsbloc/news_states.dart';
import 'package:blocnews/models/article_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    DateTime now = DateTime.now();

    String greeting = "";
    int hours = now.hour;

    if (hours >= 1 && hours <= 12) {
      greeting = "Good Morning";
    } else if (hours >= 12 && hours <= 16) {
      greeting = "Good Afternoon";
    } else if (hours >= 16 && hours <= 21) {
      greeting = "Good Evening";
    } else if (hours >= 21 && hours <= 24) {
      greeting = "Good Night";
    }

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              greeting,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  color: Colors.black),
            ),
            centerTitle: true,
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.black,
                  size: 20.0,
                ),
                onPressed: () {
                  // do something
                },
              )
            ],
          ),
          body: Stack(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: width * 0.03),
                      child: Text(
                        "Top Headlines".toUpperCase(),
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey.withOpacity(0.7),
                      width: width,
                      margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                    )
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                margin: EdgeInsets.only(top: height * 0.08),
                child: BlocBuilder<NewsBloc, NewsStates>(
                  builder: (BuildContext context, NewsStates state) {
                    if (state is NewsLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is NewsLoadedState) {
                      List<ArticleModel> _articleList = [];
                      _articleList = state.articleList;
                      return ListView.builder(
                          itemCount: _articleList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                if (Platform.isAndroid) {
                                  FlutterWebBrowser.openWebPage(
                                    url: _articleList[index].url,
                                    customTabsOptions: CustomTabsOptions(
                                      colorScheme: CustomTabsColorScheme.dark,
                                      toolbarColor: Colors.black,
                                      secondaryToolbarColor: Colors.black,
                                      navigationBarColor: Colors.black,
                                      addDefaultShareMenuItem: true,
                                      instantAppsEnabled: true,
                                      showTitle: true,
                                      urlBarHidingEnabled: true,
                                    ),
                                  );
                                } else if (Platform.isIOS) {
                                  FlutterWebBrowser.openWebPage(
                                    url: _articleList[index].url,
                                    safariVCOptions:
                                        SafariViewControllerOptions(
                                      barCollapsingEnabled: true,
                                      preferredBarTintColor: Colors.green,
                                      preferredControlTintColor: Colors.amber,
                                      dismissButtonStyle:
                                          SafariViewControllerDismissButtonStyle
                                              .close,
                                      modalPresentationCapturesStatusBarAppearance:
                                          true,
                                    ),
                                  );
                                } else {
                                  await FlutterWebBrowser.openWebPage(
                                      url: _articleList[index].url);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 1,
                                          color: Colors.grey,
                                          offset: Offset(0, 2),
                                          spreadRadius: 1)
                                    ]),
                                // height: height * 0.40,
                                margin: EdgeInsets.only(
                                    bottom: height * 0.01,
                                    top: height * 0.01,
                                    left: width * 0.04,
                                    right: width * 0.04),
                                child:
                                    /*Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 16),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            child: Image.network(
                                              _articleList[index].urlToImage !=
                                                      null
                                                  ? _articleList[index]
                                                      .urlToImage
                                                  : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSojwMMYZgtiupM4Vzdb5iBeE4b0Mamf3AgrxQJR19Xa4oIWV5xun9a02Ggyh4bZAurP_c&usqp=CAU",
                                              height: 150,
                                            )),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          _articleList[index].title,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500),
                                          maxLines: 2,
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          _articleList[index].description,
                                          maxLines: 2,
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300),
                                        )
                                      ],
                                    ),
                                  ),
                                ),*/
                                    Column(
                                  children: [
                                    Container(
                                      //width: width * 0.3,
                                      height: 160,

                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                _articleList[index]
                                                            .urlToImage !=
                                                        null
                                                    ? _articleList[index]
                                                        .urlToImage
                                                    : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSojwMMYZgtiupM4Vzdb5iBeE4b0Mamf3AgrxQJR19Xa4oIWV5xun9a02Ggyh4bZAurP_c&usqp=CAU",
                                              ),
                                              fit: BoxFit.cover)),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 60,
                                      //width: width * 0.55,
                                      padding: EdgeInsets.symmetric(
                                          vertical: height * 0.01),
                                      child: Text(
                                        _articleList[index].title,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                        maxLines: 2,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 30,
                                      //width: width * 0.55,
                                      padding: EdgeInsets.symmetric(
                                          vertical: height * 0.01),
                                      child: Row(children: [
                                        SizedBox(width: 15),
                                        Text(
                                          _articleList[index].source.name,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 9,
                                          ),
                                          maxLines: 1,
                                        ),
                                        SizedBox(width: 15),
                                        Text(
                                          _articleList[index]
                                              .publishedAt
                                              .substring(0, 10),
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 9,
                                          ),
                                          maxLines: 1,
                                        ),
                                      ]),
                                    ),

                                    /* Container(
                                      height: 40,
                                      //width: width * 0.55,
                                      child: Text(
                                        _articleList[index].description,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                        ),
                                        maxLines: 2,
                                      ),
                                    )*/
                                  ],
                                ),
                              ),
                            );
                          });
                    } else if (state is NewsErrorState) {
                      String error = state.errorMessage;

                      return Center(child: Text(error));
                    } else {
                      return Center(
                          child: CircularProgressIndicator(
                        backgroundColor: Colors.green,
                      ));
                    }
                  },
                ),
              )
            ],
          )),
    );
    // ignore: dead_code
    FloatingActionButton(
      onPressed: _refresh,
      child: new Icon(Icons.refresh),
    );
  }

  void _refresh() {
    setState(() {});
  }
}
