import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:rescue_station/app/utils/AppLayout.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import '../../routes/app_pages.dart';
import '../../theme/app_text_theme.dart';
import '../../theme/app_colors_theme.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'home_controller.dart';


class HomePage extends GetView<HomeController> {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppLayout.heigth(50)),
          child: AppBar(
            elevation: 0,
            leading: Icon(Icons.abc_rounded, size: AppLayout.fontSize(50)),
            actions: [
              IconButton(onPressed: ()=>Get.toNamed(Routes.NOTICE),
                  icon: Image.asset("assets/images/icon/email.png")),
              IconButton(onPressed: ()=>Get.toNamed(Routes.MINE),
                  icon: Image.asset("assets/images/icon/settings.png")),
            ],
          ),
        ),
        body: Obx(()=>Container(
          padding: EdgeInsets.symmetric(horizontal: AppLayout.width(8)),
          child: Column(
            children: [
              _swiper(),
              Gap(AppLayout.heigth(8)),
              _marquee(),
              Gap(AppLayout.heigth(60)),
              Center(child: Text("最高申请额度", style: AppTextTheme.headLineStyle4)),
              Gap(AppLayout.heigth(30)),
              Center(child: Text("${controller.loanAmount.value}￥", style: AppTextTheme.headLineStyle4)),
              Gap(AppLayout.heigth(30)),
              _loanSlider(context),
              Gap(AppLayout.heigth(120)),
              _submit()
            ],
          ),
        ))
    );
  }

  Widget _swiper() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppLayout.width(8)),
      child: SizedBox(
        width: AppLayout.width(1080),
        height: AppLayout.heigth(160),
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
              child: Marquee(
              text: '恭喜会员：13556779889 申请金额 50000￥审批通过',
              style: TextStyle(fontSize: AppLayout.fontSize(16), color: Colors.black87),
              scrollAxis: Axis.horizontal,
            )
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
        height: AppLayout.heigth(60),
        width: AppLayout.width(300),
        decoration: BoxDecoration(
            color: AppStyles.buttonColor,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Center(
          child: Text("立即申请", style: AppTextTheme.headLineStyle2, textAlign: TextAlign.center),
        ),
      ),
      onTap: ()=> Get.toNamed(Routes.LOAN),
    );
  }
}
