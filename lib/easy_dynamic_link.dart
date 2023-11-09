library easy_dynamic_link;

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

/// A Calculator.
class EasyDynamicLink {
  final String webPage;
  final String basicDeepLink;
  final String androidPackageName;
  final String iosBundleId;
  final String androidFallBackUrl;
  final String iosFallBackUrl;
  final String appStoreId;

  EasyDynamicLink(
      {required this.webPage,
      required this.basicDeepLink,
      required this.androidPackageName,
      required this.iosBundleId,
      required this.androidFallBackUrl,
      required this.iosFallBackUrl,
      required this.appStoreId});

  Future<String> makeDynamicLink(String path,
      {int aosMinimumVersion = 1,
      int iosMinimumVersion = 1,
      String? metaTitle,
      String? metaImgUrl,
      String? metaDescription,
      ShortDynamicLinkType? linkType}) async {
    return (await FirebaseDynamicLinks.instance.buildShortLink(
            DynamicLinkParameters(
                link: Uri.parse('$webPage/$path'),
                uriPrefix: basicDeepLink,
                androidParameters: AndroidParameters(
                    packageName: androidPackageName,
                    minimumVersion: aosMinimumVersion,
                    fallbackUrl: Uri.parse(androidFallBackUrl)),
                iosParameters: IOSParameters(
                    bundleId: iosBundleId,
                    minimumVersion: iosMinimumVersion.toString(),
                    appStoreId: appStoreId,
                    fallbackUrl: Uri.parse(iosFallBackUrl)),
                socialMetaTagParameters: metaTitle != null ||
                        metaImgUrl != null ||
                        metaDescription != null
                    ? SocialMetaTagParameters(
                        title: metaTitle,
                        imageUrl:
                            metaImgUrl != null ? Uri.parse(metaImgUrl) : null,
                        description: metaDescription)
                    : null),
            shortLinkType: linkType ?? ShortDynamicLinkType.unguessable))
        .shortUrl
        .toString();
  }
  void dynamicLinkHandler()async{
    FirebaseDynamicLinks.instance.onLink.listen((event) {

    });
  }
  //  Future<void> shareData(PendingDynamicLinkData linkData) async {
//     final Uri deepLink = linkData.link;
//     List<dynamic> linkDataList = deepLink.queryParameters.values.toList();
//     if (linkDataList.isNotEmpty) {
//       if (linkDataList.length == 1) {
//         //audition
//         int auditionIdx = int.parse(linkDataList[0]);
//         _processAuditionData(auditionIdx);
//       } else {
//         //video
//         int vod = int.parse(linkDataList[0]);
//         bool isReport = false;
//         if (linkDataList.length >= 2) {
//           isReport = linkDataList[1] == 'true';
//         }
//         VideoEntity? videoData = await getVodData(vod);
//
//         if (_shareVideo == null) {
//           _videoData = videoData;
//           _isReport = isReport;
//         } else {
//           _shareVideo?.call(videoData, isReport);
//         }
//       }
//     }
//   }

  //  void initDynamicLinkHandler() async {
//     FirebaseDynamicLinks.instance.onLink.listen((value) async {
//       shareData(value);
//     }, onError: (e) {});
//   }
}
