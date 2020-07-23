import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handler.dart';

class Routers{
  static String root = '/';
  static String mainPage = '/main';
  static String detailPage = '/detail';
  
  static void configureRouters(Router router){
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String,List<String>> params){
        print('错误路由');
        return null;
      }
    );
    router.define(mainPage, handler: mainHandle);
    router.define(detailPage, handler: detailHandle);
  }
}