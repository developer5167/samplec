import 'package:flutter/cupertino.dart';

getDeviceWidth(BuildContext context){
  return MediaQuery.of(context).size.width;
}
getDeviceHeight(BuildContext context){
 return MediaQuery.of(context).size.height;
}