import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeProvider extends ChangeNotifier {
  late ChangeNotifierProviderRef<HomeProvider> ref;
  HomeProvider(this.ref);
}
