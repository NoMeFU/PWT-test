export 'image_provider_base.dart'
    if (dart.library.io) 'image_provider_mobile.dart'
    if (dart.library.html) 'image_provider_web.dart'
    if (dart.library.js_interop) 'image_provider_web.dart';
