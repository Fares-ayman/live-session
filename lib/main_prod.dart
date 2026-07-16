import 'flavors.dart';
import 'main_common.dart';

Future<void> main() async {
  //flavors
  Flavor.appFlavor = AppFlavor.prod;
  await mainCommon();
}
