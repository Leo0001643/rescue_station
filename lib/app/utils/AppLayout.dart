import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLayout{

  static width(num v){
    return v.w;
  }
  static heigth(num v){
    return v.h;
  }
  static fontSize(num v){
    return v.sp;
  }
  static getScreenWidth(){
    return 1.sw;
  }
  static getScreenHeight(){
    return 1.sh;
  }
 }