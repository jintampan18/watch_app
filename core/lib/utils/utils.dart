import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

Future<SecurityContext> get globalContext async {
  final sslCert =
      await rootBundle.load('certificates/_.themoviedb.org.crt');
  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);

  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
  return securityContext;
}
