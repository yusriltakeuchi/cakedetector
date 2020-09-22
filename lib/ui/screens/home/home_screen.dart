
import 'dart:io';

import 'package:cakedetector/core/viewmodels/classify/classify_provider.dart';
import 'package:cakedetector/ui/constant/constant.dart';
import 'package:cakedetector/ui/widgets/component/button/primary_button.dart';
import 'package:cakedetector/ui/widgets/component/info/credits_widget.dart';
import 'package:cakedetector/ui/widgets/component/picker/picker_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tflite/tflite.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Initialize screen util
    setupScreenUtil(context);
    /// Set status bar color and icon
    setStatusBar(brightness: Brightness.dark);

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        brightness: Brightness.dark,
        title: Row(
          children: [
            Text(
              "Cake",
              style: styleTitle.copyWith(
                color: Colors.white,
                fontSize: setFontSize(60)
              ),
            ),
            SizedBox(width: 3),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Text(
                  " Detector",
                  style: styleTitle.copyWith(
                    color: primaryColor,
                    fontSize: setFontSize(60)
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info, color: Colors.white),
            onPressed: () => CreditWidgets.show(context)
          )
        ],
      ),
      body: HomeBody(),
    );
  }
}

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {

  /// Image result from picker image
  File image;

  /// Pick some pictures 
  /// and scan the images
  void choosePicture() async {
    final classifyProv = Provider.of<ClassifyProvider>(context, listen: false);

    /// Take picture just only availble on idle and complete state
    if (classifyProv.scanState == ClassifyState.Idle || classifyProv.scanState == ClassifyState.Complete) {
      await PickerImage.pick(context, (_image) {
        setState(() {
          image = _image;
        });
        classifyProv.scan(context, _image);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  _circleButtonScan(),
                  _contentBody()
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _circleButtonScan() {
    return Consumer<ClassifyProvider>(
      builder: (context, classifyProv, _) {

        return GestureDetector(
          onTap: () => choosePicture(),
          onLongPress: classifyProv.onButtonTapAndHold,
          onLongPressEnd: (value) => classifyProv.onButtonRelease(),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 100),
            margin: EdgeInsets.only(bottom: 40, top: 40),
            width: setWidth(classifyProv.buttonSize),
            height: setHeight(classifyProv.buttonSize),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.white, Colors.white.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            ),
            child: classifyProv.scanState == ClassifyState.Scanning 
              ? Shimmer.fromColors(
                  baseColor: primaryColor.withOpacity(1),
                  highlightColor: blackColor.withOpacity(0.1),
                  child: _centerScanText(),
                )
              : _centerScanText(),
          ),
        );
      },
    );
  }

  Widget _centerScanText() {
    return Consumer<ClassifyProvider>(
      builder: (context, classifyProv, _) {
        return Center(
          child: Text(
            classifyProv.scanText,
            style: styleTitle.copyWith(
              color: primaryColor,
              fontSize: setFontSize(classifyProv.scanFontSize)
            ),
          ),
        );
      },
    );
  }

  Widget _contentBody() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50)
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Consumer<ClassifyProvider>(
            builder: (context, classifyProv, _) {
              
              /// When widget state is idle
              if (classifyProv.scanState == ClassifyState.Idle) {
                return _contentIdle();
              }
              
              /// When widget state is scanning
              if (classifyProv.scanState == ClassifyState.Scanning) {
                return _contentScanning();
              }

              /// When widget state is complete
              if (classifyProv.scanState == ClassifyState.Complete) {
                return _contentComplete();
              }

              return SizedBox();
            },
          ) 
        ),
      ),
    );
  }

  Widget _contentComplete() {
    return Consumer<ClassifyProvider>(
      builder: (contxt, classifyProv, _) {

        return Container(
          width: deviceWidth(),
          child: Column(
            children: [
              SizedBox(height: 30),
              Container(
                width: deviceWidth() / 2,
                height: setHeight(300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: primaryColor, width: 2),
                  image: DecorationImage(
                    image: FileImage(image),
                    fit: BoxFit.cover
                  )
                ),
              ),
              SizedBox(height: 15),
              Text(
                classifyProv.cakeResult ?? "Kue Tidak Diketahui",
                style: styleTitle.copyWith(
                  color: primaryColor,
                  fontSize: setFontSize(50)
                ),
              ),
              SizedBox(height: 10),
              Text(
                classifyProv.cakeResult != null
                ? "Detektif mengatakan bahwa ini adalah sebuah ${classifyProv.cakeResult}, jika kurang tepat coba cari tahu lagi"
                : "Detektif tidak mengetahui jenis kue ini",
                textAlign: TextAlign.center,
                style: styleSubtitle.copyWith(
                  fontSize: setFontSize(35)
                ),
              ),
              SizedBox(height: 20),
              PrimaryButton(
                color: primaryColor,
                title: "Cari Tahu Lagi",
                onClick: () => choosePicture(),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _contentScanning() {
    return Column(
      children: [
        SizedBox(height: 30),
        Container(
          width: deviceWidth(),
          height: setHeight(350),
          child: SvgPicture.asset("$imageAsset/image_scanning.svg")
        ),
        SizedBox(height: 10),
        Text(
          "Detektif sedang mencari tahu \njenis kue...",
          textAlign: TextAlign.center,
          style: styleTitle.copyWith(
            fontSize: setFontSize(40)
          ),
        )
      ],
    );
  }

  Widget _contentIdle() {
    return Column(
      children: [
        SizedBox(height: 30),
        Container(
          width: deviceWidth(),
          height: setHeight(350),
          child: SvgPicture.asset("$imageAsset/image_cake.svg")
        ),
        SizedBox(height: 40),
        _informationWidget()
      ],
    );
  }

  Widget _informationWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Cara menggunakan aplikasi:",
          style: styleTitle.copyWith(
            fontSize: setFontSize(40)
          ),
        ),
        Text(
          '''1. Tekan tombol Scan Now pada bagian atas
2. Pilih lokasi pengambilan gambar
3. Aplikasi akan memprediksi kue yang ada pada gambarmu''',
          style: styleSubtitle.copyWith(
            fontSize: setFontSize(35)
          )
        )
      ],
    );
  }
}