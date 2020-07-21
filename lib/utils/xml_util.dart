import 'package:v_player/models/category_model.dart';
import 'package:v_player/models/video_model.dart';
import 'package:xml/xml.dart' as xml;

class XmlUtil {
  static List<CategoryModel> parseCategoryList(String xmlStr) {
    List<CategoryModel> list = [];
    try {
      final document = xml.parse(xmlStr);
      final types = document.findAllElements('ty');
      types.forEach((node) {
        list.add(CategoryModel(id: node.getAttribute('id'), name: node.text));
      });
    } catch (e) {
      print(e);
    }
    return list;
  }

  static List<VideoModel> parseVideoList(String xmlStr) {
    List<VideoModel> list = [];
    try {
      final document = xml.parse(xmlStr);
      final videos = document.findAllElements('video');
      videos.forEach((node) {
        list.add(VideoModel(
          id: getNodeText(node, 'id'),
          tid: getNodeText(node, 'tid'),
          name: getNodeCData(node, 'name'),
          type: getNodeText(node, 'type'),
          pic: getNodeText(node, 'pic'),
          lang: getNodeText(node, 'lang'),
          area: getNodeText(node, 'area'),
          year: getNodeText(node, 'year'),
          state: int.parse(getNodeText(node, 'state') ?? 0),
          note: getNodeCData(node, 'note'),
          actor: getNodeCData(node, 'actor'),
          director: getNodeCData(node, 'director'),
          des: getNodeCData(node, 'des')
        ));
      });
    } catch (e) {
      print(e);
    }
    return list;
  }

  static VideoModel parseVideo(String xmlStr) {
    try {
      final document = xml.parse(xmlStr);
      final video = document.findAllElements('video').first;
      if (video == null) return null;
      List<Anthology> anthologies = [];
      String str = getNodeCData(video.findElements('dl').first, 'dd');
      if (str != null && str.indexOf('#') > -1) {
        str.split('#').forEach((s) {
          if (s.indexOf('\$') > -1) {
            anthologies.add(Anthology(name: s.split('\$')[0], url: s.split('\$')[1]));
          }
        });
      }
      anthologies.forEach((e) {
        print(e.toJson());
      });
      return VideoModel(
        id: getNodeText(video, 'id'),
        tid: getNodeText(video, 'tid'),
        name: getNodeCData(video, 'name'),
        type: getNodeText(video, 'type'),
        pic: getNodeText(video, 'pic'),
        lang: getNodeText(video, 'lang'),
        area: getNodeText(video, 'area'),
        year: getNodeText(video, 'year'),
        state: int.parse(getNodeText(video, 'state') ?? 0),
        note: getNodeCData(video, 'note'),
        actor: getNodeCData(video, 'actor'),
        director: getNodeCData(video, 'director'),
        des: getNodeCData(video, 'des'),
        anthologies: anthologies
      );
    } catch (e) {
      print(e);
    }
    return null;
  }

  static String getNodeText(xml.XmlElement node, String name) {
    if (node == null) return null;
    final elements = node.findElements(name);
    if (elements.isEmpty || elements.first == null) return null;
    return elements.first.text;
  }

  static String getNodeCData(xml.XmlElement node, String name) {
    if (node == null) return null;
    final elements = node.findElements(name);
    if (elements.isEmpty || elements.first == null) return null;
    final children = node.findElements(name).first.children;
    if (children.isEmpty || children.first == null) return null;
    return children.first.text;
  }
}