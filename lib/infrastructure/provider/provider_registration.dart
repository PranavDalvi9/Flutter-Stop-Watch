import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_provider/home_provider.dart';

final homeProvider = ChangeNotifierProvider<HomeProvider>((ref) => HomeProvider(ref));
