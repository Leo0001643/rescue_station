import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/domains/marquee_entity.dart';
import 'package:rescue_station/app/routes/api_info.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/utils/network/request_client.dart';

class HomeController extends GetxController{
  final RequestClient requestClient = RequestClient();
  RxDouble loanAmount = 0.0.obs;
  Rx<Data> data = Data().obs;

  @override
  void onInit() {
    super.onInit();
    setLoanAmount(200000.0);
    getMarquee();
  }

  @override
  void onClose() {
    super.onClose();
  }

  ///进入页面设置默认贷款金额
  void setLoanAmount(loanAmount){
    this.loanAmount.value = loanAmount;
    update();
  }

  ///获取广播内容
  getMarquee() async{
    var response = await requestClient.get(Api.MARQUEE, headers: {"version": "1.0.1"});
    if(isNotEmpty(response)){
      data.value = Data.fromJson(response);
      update();
    }
  }

}
