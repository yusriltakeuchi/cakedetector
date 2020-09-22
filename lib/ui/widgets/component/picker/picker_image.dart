import 'dart:io';

import 'package:cakedetector/ui/constant/constant.dart';
import 'package:cakedetector/ui/widgets/component/slider/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

enum PickType { 
   Camera, 
   Gallery, 
}

class PickerImage {

  static Future<File> pickImage(PickType type) async {
    var file = await ImagePicker().getImage(source: type == PickType.Camera 
      ? ImageSource.camera
      : ImageSource.gallery);

    return File(file.path);
  }


  /// Function to pick image from
  /// gallery or camera
  static pick(BuildContext context, Function(File) callback) {
    ModalBottomSheet.show(
      title: "Pilih Lokasi Gambar",
      context: context,
      radiusCircle: 40,
      children: [
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            pickWidget(
              iconPath: "$iconAsset/icon_camera.svg",
              title: "Kamera",
              onClick: () async {
                await callback(await pickImage(PickType.Camera));
                Navigator.pop(context);
              }
            ),
            pickWidget(
              iconPath: "$iconAsset/icon_gallery.svg",
              title: "Galeri",
              onClick: () async {
                await callback(await pickImage(PickType.Gallery));
                Navigator.pop(context);
              }
            )
          ],
        )
      ], 
    );
  }

  static Widget pickWidget({String iconPath, String title, Function onClick}) {
    return Column(
      children: [
        Container(
          width: setWidth(200),
          height: setHeight(200),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: primaryColor
          ),
          child: GestureDetector(
            onTap: () => onClick(),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: SvgPicture.asset(
                iconPath, 
                color: Colors.white,
              ),
            ),
          )
        ),
        SizedBox(height: 10),
        Text(
          title,
          style: styleTitle.copyWith(
            fontSize: setFontSize(40)
          ),
        )
      ],
    );
  }
}