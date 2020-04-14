// To parse this JSON data, do
//
//     final articleListResponse = articleListResponseFromJson(jsonString);

import 'dart:convert';

ArticleListResponse articleListResponseFromJson(String str) => ArticleListResponse.fromJson(json.decode(str));

String articleListResponseToJson(ArticleListResponse data) => json.encode(data.toJson());

class ArticleListResponse {
    List<Datum> data;
    int errorCode;
    String errorMsg;

    ArticleListResponse({
        this.data,
        this.errorCode,
        this.errorMsg,
    });

    factory ArticleListResponse.fromJson(Map<String, dynamic> json) => ArticleListResponse(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        errorCode: json["errorCode"],
        errorMsg: json["errorMsg"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "errorCode": errorCode,
        "errorMsg": errorMsg,
    };
}

class Datum {
    String apkLink;
    int audit;
    String author;
    bool canEdit;
    int chapterId;
    String chapterName;
    bool collect;
    int courseId;
    String desc;
    String descMd;
    String envelopePic;
    bool fresh;
    int id;
    String link;
    String niceDate;
    String niceShareDate;
    String origin;
    String prefix;
    String projectLink;
    int publishTime;
    int selfVisible;
    int shareDate;
    String shareUser;
    int superChapterId;
    String superChapterName;
    List<Tag> tags;
    String title;
    int type;
    int userId;
    int visible;
    int zan;

    Datum({
        this.apkLink,
        this.audit,
        this.author,
        this.canEdit,
        this.chapterId,
        this.chapterName,
        this.collect,
        this.courseId,
        this.desc,
        this.descMd,
        this.envelopePic,
        this.fresh,
        this.id,
        this.link,
        this.niceDate,
        this.niceShareDate,
        this.origin,
        this.prefix,
        this.projectLink,
        this.publishTime,
        this.selfVisible,
        this.shareDate,
        this.shareUser,
        this.superChapterId,
        this.superChapterName,
        this.tags,
        this.title,
        this.type,
        this.userId,
        this.visible,
        this.zan,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        apkLink: json["apkLink"],
        audit: json["audit"],
        author: json["author"],
        canEdit: json["canEdit"],
        chapterId: json["chapterId"],
        chapterName: json["chapterName"],
        collect: json["collect"],
        courseId: json["courseId"],
        desc: json["desc"],
        descMd: json["descMd"],
        envelopePic: json["envelopePic"],
        fresh: json["fresh"],
        id: json["id"],
        link: json["link"],
        niceDate: json["niceDate"],
        niceShareDate: json["niceShareDate"],
        origin: json["origin"],
        prefix: json["prefix"],
        projectLink: json["projectLink"],
        publishTime: json["publishTime"],
        selfVisible: json["selfVisible"],
        shareDate: json["shareDate"],
        shareUser: json["shareUser"],
        superChapterId: json["superChapterId"],
        superChapterName: json["superChapterName"],
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        title: json["title"],
        type: json["type"],
        userId: json["userId"],
        visible: json["visible"],
        zan: json["zan"],
    );

    Map<String, dynamic> toJson() => {
        "apkLink": apkLink,
        "audit": audit,
        "author": author,
        "canEdit": canEdit,
        "chapterId": chapterId,
        "chapterName": chapterName,
        "collect": collect,
        "courseId": courseId,
        "desc": desc,
        "descMd": descMd,
        "envelopePic": envelopePic,
        "fresh": fresh,
        "id": id,
        "link": link,
        "niceDate": niceDate,
        "niceShareDate": niceShareDate,
        "origin": origin,
        "prefix": prefix,
        "projectLink": projectLink,
        "publishTime": publishTime,
        "selfVisible": selfVisible,
        "shareDate": shareDate,
        "shareUser": shareUser,
        "superChapterId": superChapterId,
        "superChapterName": superChapterName,
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
        "title": title,
        "type": type,
        "userId": userId,
        "visible": visible,
        "zan": zan,
    };
}

class Tag {
    String name;
    String url;

    Tag({
        this.name,
        this.url,
    });

    factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}