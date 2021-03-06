import 'dart:async';

import 'Api.dart';
import 'HttpUtils.dart';

import 'package:play_android/Responses/BannerResponse.dart';
import 'package:play_android/Responses/ArticleTopListResponse.dart';
import 'package:play_android/Responses/HotKeyResponse.dart';
import 'package:play_android/Responses/InformationFlowTopicResponse.dart';
import 'package:play_android/Responses/InformationFlowListResponse.dart';
import 'package:play_android/Responses/AccountInfoResponse.dart';
import 'package:play_android/Responses/LogoutResponse.dart';
import 'package:play_android/Responses/CollectArticleActionResponse.dart';
import 'package:play_android/Responses/MyCollectResponse.dart';
import 'package:play_android/Responses/RankListResponse.dart';
import 'package:play_android/Responses/MyCoinResponse.dart';
import 'package:play_android/Responses/CoinResponse.dart';

// Dart的分类需要在Dart2.6以上的版本才能使用,修改了配置文件
extension Request on HttpUtils {
  // 获取轮播图数据
  static Future<BannerResponse> getBanner() async {
    var json = await HttpUtils.get(api: Api.getBanner);
    return BannerResponse.fromJson(json);
  }

  // 获取首页置顶文章
  static Future<ArticleTopListResponse> getTopArticleList() async {
    var json = await HttpUtils.get(api: Api.getTopArticleList);
    return ArticleTopListResponse.fromJson(json);
  }

  // 通过page获取首页文章
  static Future<InformationFlowListResponse> getArticleList({int page}) async {
    var json = await HttpUtils.get(api: Api.getArticleList + page.toString() + "/json");
    return InformationFlowListResponse.fromJson(json);
  }

  // 搜索热词
  static Future<HotKeyResponse> getSearchHotKey() async {
    var json = await HttpUtils.get(api: Api.getSearchHotKey);
    return HotKeyResponse.fromJson(json);
  }

  // 通过关键词与page进行搜索,获取搜索结果
  static Future<InformationFlowListResponse> postQueryKey({int page, String keyword}) async {
    Map<String, String> params = Map();
    params["k"] = keyword;
    var json = await HttpUtils.post(api: Api.postQueryKey + page.toString() + "/json", params: params);
    return InformationFlowListResponse.fromJson(json);
  }

  // 项目分类
  static Future<InformationFlowTopicResponse> getProjectClassify() async {
    var json = await HttpUtils.get(api: Api.getProjectClassify);
    return InformationFlowTopicResponse.fromJson(json);
  }

  // 通过id与page获取单个项目分类的列表
  static Future<InformationFlowListResponse> getProjectClassifyList({int page, int id}) async {
    Map<String, String> params = Map();
    params["cid"] = id.toString();
    var json = await HttpUtils.get(api: Api.getProjectClassifyList + page.toString() + "/json", params: params);
    return InformationFlowListResponse.fromJson(json);
  }

  // 公众号分类
  static Future<InformationFlowTopicResponse> getPubilicNumber() async {
    var json = await HttpUtils.get(api: Api.getPubilicNumber);
    return InformationFlowTopicResponse.fromJson(json);
  }

  // 通过id与page获取单个公众号分类的列表
  static Future<InformationFlowListResponse> getPubilicNumberList({int page, int id}) async {
    var json = await HttpUtils.get(api: Api.getPubilicNumberList + id.toString() + "/" + page.toString() + "/json");
    return InformationFlowListResponse.fromJson(json);
  }

  // 登录
  static Future<AccountInfoResponse> login({String username, String password}) async {
    Map<String, String> params = Map();
    params["username"] = username;
    params["password"] = password;
    var json = await HttpUtils.post(api: Api.postLogin, params: params);
    return AccountInfoResponse.fromJson(json);
  }

  // 注册
  static Future<AccountInfoResponse> register({String username, String password, String rePassword}) async {
    Map<String, String> params = Map();
    params["username"] = username;
    params["password"] = password;
    params["repassword"] = rePassword;
    var json = await HttpUtils.post(api: Api.postRegister, params: params);
    return AccountInfoResponse.fromJson(json);
  }

  // 登出
  static Future<LogoutResponse> logout() async {
    var json = await HttpUtils.get(api: Api.getLogout);
    return LogoutResponse.fromJson(json);
  }

  // 文章收藏
  static Future<CollectArticleActionResponse> collectAction({int id}) async {
    var json = await HttpUtils.post(api: Api.postCollectArticle + id.toString() + "/json");
    return CollectArticleActionResponse.fromJson(json);
  }

  // 取消收藏
  static Future<CollectArticleActionResponse> unCollectAction({int originId,}) async {
    var json = await HttpUtils.post(api: Api.postUnCollectArticle + originId.toString() + "/json");
    return CollectArticleActionResponse.fromJson(json);
  }

  // 收藏文章列表
  static Future<MyCollectResponse> getCollectArticleList({int page}) async {
    var json = await HttpUtils.get(api: Api.getCollectArticleList + page.toString() + "/json");
    return MyCollectResponse.fromJson(json);
  }
  
  // 积分排行榜
  static Future<RankListResponse> getRankingList({int page}) async {
    var json = await HttpUtils.get(api: Api.getRankingList + page.toString() + "/json");
    return RankListResponse.fromJson(json);
  }

  // 个人获取积分的历史记录
  static Future<MyCoinResponse> getCoinList({int page}) async {
    var json = await HttpUtils.get(api: Api.getCoinList + page.toString() + "/json");
    return MyCoinResponse.fromJson(json);
  }
  
  // 个人积分信息
  static Future<CoinResponse> getUserCoinInfo() async {
    var json = await HttpUtils.get(api: Api.getUserCoinInfo);
    return CoinResponse.fromJson(json);
  }
}