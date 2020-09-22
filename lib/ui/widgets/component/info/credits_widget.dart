import 'package:cakedetector/ui/constant/constant.dart';
import 'package:cakedetector/ui/widgets/component/slider/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';

class CreditWidgets {

  static show(BuildContext context) {
    ModalBottomSheet.show(
      title: "Tentang Aplikasi",
      context: context,
      radiusCircle: 40,
      children: [
        SizedBox(height: 20),
        _information(),
        Divider(color: Colors.black.withOpacity(0.4)),
        _author()
      ], 
    );
  }

  static Widget _author() {
    return Text(
      '''Model Trained by: Yusril Rapsanjani
Coded made by: Yusril Rapsanjani

Website: https://leeyurani.com/''',
      style: styleSubtitle.copyWith(
        fontSize: setFontSize(40)
      ),
    );
  }
  static Widget _information() {
    return Text(
      '''Cake Detector adalah sebuah aplikasi yang dapat 
mendeteksi sebuah kue dari gambar yang dimasukkan oleh pengguna. Karena keterbatasan data trainning, saat ini Cake Detector hanya dapat memprediksi kue seperti berikut:
1. Kue Dadar Gulung
2. Kue Kastengel
3. Kue Klepon
4. Kue Lapis
5. Kue Lumpur,
6. Kue Putri Salju
7. Risoles
8. Kue Serabi''',
      style: styleSubtitle.copyWith(
        fontSize: setFontSize(40)
      ),
    );
  }
}