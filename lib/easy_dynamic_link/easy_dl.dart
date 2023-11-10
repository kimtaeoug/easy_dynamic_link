library easy_dynamic_link;

import 'dart:async';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';

///
/// Firebase DynamicLink를 쉽게 다루게 합니다.
///
class EasyDL {
  ///
  /// SingleTone Pattern
  ///
  static final EasyDL _link = EasyDL._();

  EasyDL._();

  factory EasyDL() => _link;

  late FirebaseDynamicLinks? _fbd;
  final ValueNotifier<bool> _fbdInitialized = ValueNotifier<bool>(false);

  void initFbd() async {
    _fbd = FirebaseDynamicLinks.instance;
    _fbdInitialized.value = true;
  }

  ///
  /// Firebase DynamicLink를 활용해 DeepLink를 만드는 함수입니다.
  ///
  Future<String?> makeDynamicLink(
      String path,
      String webPage,
      String basicDeepLink,
      String androidPackageName,
      String iosBundleId,
      String androidFallBackUrl,
      String iosFallBackUrl,
      String appStoreId,
      {int aosMinimumVersion = 1,
        int iosMinimumVersion = 1,
        String? metaTitle,
        String? metaImgUrl,
        String? metaDescription,
        ShortDynamicLinkType? linkType}) async {
    if (_fbd != null && _fbdInitialized.value == true) {
      return (await _fbd!.buildShortLink(
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
    } else {
      throw Exception('FirebaseDynamicLink is not initialized');
      return null;
    }
  }

  ///
  /// Firebase Dynamic Link를 처리하는 handler입니다.
  /// 해당 함수는 앱이 Active상태가 아니면 값을 읽을 수 없으니 이럴 경우에는 UniLink를 활용하시기 바랍니다.
  ///
  void handler(Function(Uri, List<dynamic>) function,
      {Function()? onDone, Function(Object, StackTrace)? onError}) async {
    if (_fbd != null && _fbdInitialized.value == true) {
      _fbd!.onLink.listen((event) {
        _processPendingDynamicLinkData.call(event, function);
      }, onDone: () => onDone?.call(), onError: (e, s) => onError?.call(e, s));
    } else {
      throw Exception('FirebaseDynamicLink is not initialized');
    }
  }

  ///
  /// Firebase DynamicLink를 통해 들어온 데이터를 쉽게 처리하는 함수입니다.
  ///
  void _processPendingDynamicLinkData(
      PendingDynamicLinkData data, Function(Uri, List<dynamic>) function) {
    final Uri deepLink = data.link;
    final List<dynamic> linkDataList = deepLink.queryParameters.values.toList();
    function.call(deepLink, linkDataList);
  }
}
