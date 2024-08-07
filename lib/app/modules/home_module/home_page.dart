import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:rescue_station/app/modules/tabs_module/tabs_controller.dart';
import 'package:rescue_station/app/utils/AppLayout.dart';
import '../../routes/app_pages.dart';
import '../../theme/app_colors_theme.dart';
import '../../theme/app_text_theme.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StateHomePage();
}

class StateHomePage extends State<HomePage>{
  final controller = Get.find<HomeController>();
  final tabsController = Get.find<TabsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppLayout.heigth(60)),
          child: _appBar(),
        ),
        body: SingleChildScrollView(
          child: Obx(()=>Container(
            padding: EdgeInsets.symmetric(horizontal: AppLayout.width(8)),
            child: Column(
              children: [
                _swiper(),
                Gap(AppLayout.heigth(8)),
                _marquee(),
                Gap(AppLayout.heigth(30)),
                Center(child: Text("最高申请额度", style: AppTextTheme.headLineStyle4)),
                Gap(AppLayout.heigth(30)),
                Center(child: Text("${controller.loanAmount.value}￥", style: AppTextTheme.headLineStyle4)),
                Gap(AppLayout.heigth(30)),
                _loanSlider(context),
                Gap(AppLayout.heigth(48)),
                _submit()
              ],
            ),
          )),
        )
    );
  }

  Widget _appBar(){
    return AppBar(
      elevation: 0,
      titleSpacing: 0,
      title: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: AppLayout.width(160),
          height: AppLayout.heigth(38),
          child: Image.asset("assets/images/icon/logo-nav.png", fit: BoxFit.fitHeight),
        ),
      ),
      actions: [
        IconButton(onPressed: ()=>Get.toNamed(Routes.NOTICE),
            icon: Image.asset("assets/images/icon/email.png",fit: BoxFit.cover)),
        // IconButton(onPressed: ()=>Get.toNamed(Routes.MINE),
        //     icon: Image.asset("assets/images/icon/settings.png",fit: BoxFit.cover)),
      ],
    );
  }

  Widget _swiper() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppLayout.width(8)),
      child: SizedBox(
        width: double.infinity,
        height: AppLayout.heigth(140),
        child: Swiper(
            autoplay: true,
            loop: true,
            itemCount: 3,
            pagination: const SwiperPagination(builder: SwiperPagination.rect),
            itemBuilder: (context, index) {
              return Image.asset("assets/images/banner/banner${index + 1}.png", fit: BoxFit.cover,);
            }
        ),
      ),
    );
  }

  Widget _marquee() {
    return Container(
      height: AppLayout.heigth(30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppLayout.heigth(4)),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color.fromRGBO(251,245,255,.9), Color.fromRGBO(237, 214, 255, .9)],
          )
      ),
      child: Row(
        children: [
          Container(
            height: AppLayout.heigth(28),
            width: AppLayout.width(28),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/icon/bell.png")
                )
            ),
          ),
          Gap(AppLayout.width(5)),
          Expanded(
              child: Obx((){
                if(isEmpty(controller.data.value)) {
                  return Container();
                }
                return Marquee(
                  text: "${controller.data.value.content}",
                  blankSpace: AppLayout.width(18),
                  style: TextStyle(fontSize: AppLayout.fontSize(16), color: Colors.black87),
                  scrollAxis: Axis.horizontal,
                );
              })
          )
        ],
      ),
    );
  }

  Widget _loanSlider(BuildContext context){
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
          activeTrackColor: const Color.fromRGBO(112, 50, 255, 1), //进度条滑块左边颜色
          inactiveTrackColor: const Color.fromRGBO(112, 50, 255, .5), //进度条滑块右边颜色
          thumbColor: const Color.fromRGBO(112, 50, 255, .9), //滑块颜色
          // overlayColor: Colors.green, //滑块拖拽时外圈的颜色
          overlayShape: const RoundSliderOverlayShape(//可继承SliderComponentShape自定义形状
            overlayRadius: 35, //滑块外圈大小
          ),
          thumbShape: const RoundSliderThumbShape(//可继承SliderComponentShape自定义形状
            disabledThumbRadius: 15, //禁用是滑块大小
            enabledThumbRadius: 25, //滑块大小
          ),
          inactiveTickMarkColor: Colors.black,
          tickMarkShape: const RoundSliderTickMarkShape(//继承SliderTickMarkShape可自定义刻度形状
            tickMarkRadius: 4.0,//刻度大小
          ),
          showValueIndicator: ShowValueIndicator.onlyForDiscrete,//气泡显示的形式
          valueIndicatorColor: Colors.pink.shade300,//气泡颜色
          valueIndicatorShape: const PaddleSliderValueIndicatorShape(),//气泡形状
          valueIndicatorTextStyle: const TextStyle(color: Colors.black),//气泡里值的风格
          trackHeight: 25 //进度条宽度
      ),
      child: Slider(
        value: controller.loanAmount.value,
        onChanged: (v) {
          controller.setLoanAmount(v);
        },
        label: "申请额度:${controller.loanAmount.value}",//气泡的值
        divisions: 10, //进度条上显示多少个刻度点
        max: 200000,
        min: 0,
      ),
    );
  }

  Widget _submit(){
    return InkWell(
      child: Container(
        height: AppLayout.heigth(46),
        width: AppLayout.width(260),
        decoration: BoxDecoration(
            color: AppStyles.buttonColor,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Center(
          child: Text("立即申请", style: AppTextTheme.headLineStyle2, textAlign: TextAlign.center),
        ),
      ),
      onTap: (){
        if(!tabsController.isLogin.value){
          tabsController.navigateToLogin();
        }else{
          Get.toNamed(Routes.LOAN);
        }
      }
    );
  }
}
