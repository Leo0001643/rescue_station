import 'package:get/get.dart';
import 'package:rescue_station/app/utils/request_client.dart';

class HomeController extends GetxController{
  final RequestClient requestClient = RequestClient();

  RxDouble loanAmount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    setLoanAmount(200000.0);
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setLoanAmount(loanAmount){
    this.loanAmount.value = loanAmount;
    update();
  }

  ///获取广播内容
  getMarquee()async{
    await requestClient.get("/marquee/info");

  }

}
