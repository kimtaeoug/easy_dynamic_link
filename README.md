<h1 align="center">Easy Dynamic Link</h1>  
## 😀 About Easy Dynamic Link
This is a project that makes the dynamic link in Firebase easy to use. The features in this project are as follows.  
+ Dynamic Link Handler
+ make Dyanmic Link easily
> To use the project, you must set firebase on the app by default.
## Usage  
```dart
    final EasyDL _easyDL = EasyDL();
    _easyDL.init();
    //make Dyanmic Link easily  
    _easyDL.makeDynamicLink(
        path,
        webPage,
        basicDeepLink,
        androidPackageName,
        iosBundleId,
        androidFallBackUrl,
        iosFallBackUrl,
        appStoreId);
    //Dynamic Link Handler
    _easyDL.handler((uri, data){});
```
