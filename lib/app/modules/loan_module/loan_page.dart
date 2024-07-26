import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../utils/AppLayout.dart';
import 'loan_controller.dart';
import '../../theme/app_colors_theme.dart';

class LoanPage extends GetView<LoanController> {

  const LoanPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text('补充信息', style: TextStyle(fontSize: AppLayout.fontSize(18)),),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: ()=>Get.back(),
      ),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: AppLayout.width(16)),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppLayout.width(4)), color: Colors.blue[100]),
              padding: EdgeInsets.all(AppLayout.width(8)),
              child: Text('请如实填写个人信息，用于核实真实性以及方便后续服务',textAlign: TextAlign.start,style: TextStyle(color: Colors.black,fontSize: AppLayout.fontSize(14))),
            ),
            Gap(AppLayout.heigth(8)),
            Form(
              key: controller.formKey,
              child: Container(
                padding: EdgeInsets.all(AppLayout.width(16)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppLayout.width(8)),
                ),
                child: Column(
                  children: [
                    _buildTextField(
                      labelText: '姓名：',
                      textInputType: TextInputType.text,
                      validator: _validateRealName,
                      onChanged: (value) => controller.realname.value = value,
                    ),
                    _buildTextField(
                      labelText: '手机号：',
                      textInputType: TextInputType.number,
                      validator: (value)=>_validatePhoneNumber(value),
                      onChanged: (value) => controller.phone.value = value,
                    ),
                    _buildTextField(
                      labelText: '身份证：',
                      textInputType: TextInputType.text,
                      validator: _validateIdentityId,
                      onChanged: (value) => controller.identityId.value = value,
                    ),
                    _buildTextField(
                      labelText: '家庭住址：',
                      textInputType: TextInputType.text,
                      validator: _validateHomeAddress,
                      onChanged: (value) => controller.homeAddress.value = value,
                    ),
                    _buildTextField(
                      labelText: '家庭月收入：',
                      textInputType: TextInputType.number,
                      validator: _validateHomeRevenue,
                      onChanged: (value) => controller.homeRevenue.value = value,
                    ),
                    _buildTextField(
                      labelText: '申请金额：',
                      textInputType: TextInputType.number,
                      validator: _validateLoanAmount,
                      onChanged: (value) => controller.loanAmount.value = value,
                    ),
                    _buildTextField(
                      labelText: '申请理由：',
                      textInputType: TextInputType.text,
                      validator: _validateReason,
                      maxLines: 3,
                      onChanged: (value) => controller.reason.value = value,
                    ),
                    Gap(AppLayout.heigth(16)),
                    InkWell(
                      onTap: controller.submitForm,
                      child: Container(
                        height: AppLayout.heigth(48),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: AppStyles.buttonColor),
                        child: Text('提交申请',style: TextStyle(fontSize: AppLayout.fontSize(18),color: Colors.white, fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }


  Widget _buildTextField({required String labelText,required TextInputType textInputType,required String? Function(String?) validator,int maxLines = 1,required Function(String) onChanged}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        maxLines: maxLines,
        keyboardType: textInputType,
        decoration: InputDecoration(
          labelText: labelText,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppLayout.width(6)),
            // borderSide: BorderSide.none,
          ),
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }

  final String _realPattern = r'^[\u4e00-\u9fa5]{2,}$';
  String? _validateRealName(String? value) {
    if (value == null || value.isEmpty) {
      return '姓名是必填项';
    }
    final regex = RegExp(_realPattern);
    if (!regex.hasMatch(value)) {
      return '请输入有效的中文姓名';
    }
    return null;
  }

  final String _phonePattern = r'^1[3-9]\d{9}$';
  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return '手机号是必填项';
    }
    final regex = RegExp(_phonePattern);
    if (!regex.hasMatch(value)) {
      return '请输入有效的手机号';
    }
    return null;
  }

  // Regex pattern for Chinese ID card validation
  final String _identityIdPattern = r'^[0-9A-Z]{15,18}$';
  String? _validateIdentityId(String? value) {
    if (value == null || value.isEmpty) {
      return '身份证号是必填项';
    }
    final regex = RegExp(_identityIdPattern);
    if (!regex.hasMatch(value)) {
      return '请输入有效的身份证号';
    }
    return null;
  }

  String? _validateHomeAddress(String? value) {
    if (value == null || value.isEmpty) {
      return '家庭住址是必填项';
    }
    if (value.length < 2 || value.length > 60) {
      return '家庭住址长度应在2到60个字符之间';
    }
    return null;
  }


  String? _validateHomeRevenue(String? value) {
    if (value == null || value.isEmpty) {
      return '家庭月收入是必填项';
    }
    final numericRegex = RegExp(r'^\d+$');
    if (!numericRegex.hasMatch(value)) {
      return '家庭月收入必须是纯数字';
    }
    return null;
  }


  String? _validateLoanAmount(String? value) {
    if (value == null || value.isEmpty) {
      return '申请金额是必填项';
    }
    final numericRegex = RegExp(r'^\d+$');
    if (!numericRegex.hasMatch(value)) {
      return '申请金额必须是纯数字';
    }
    return null;
  }

  String? _validateReason(String? value) {
    if (value == null || value.isEmpty) {
      return '申请理由是必填项';
    }
    if (value.length < 2 || value.length > 200) {
      return '申请理由长度应在2到200个字符之间';
    }
    return null;
  }

}
