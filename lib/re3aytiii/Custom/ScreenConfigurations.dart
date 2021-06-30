import 'package:flutter/material.dart';

enum ScreenType{
  SMALL, MEDIUM, LARGE
}

class ScreenConfigurations{
  BuildContext context;
  double screenWidth;
  double screenHeight;
  ScreenType screenType;

  ScreenConfigurations(this.context){
    this.screenWidth = MediaQuery.of(context).size.width;
    this.screenHeight = MediaQuery.of(context).size.height;
    _setScreen();
  }

  void _setScreen(){
    if(this.screenWidth >= 320 && this.screenWidth < 375){
      this.screenType = ScreenType.SMALL;
    }
    if(this.screenWidth >= 375 && this.screenWidth <= 414){
      this.screenType = ScreenType.MEDIUM;
    }
    if(this.screenWidth > 414){
      this.screenType = ScreenType.LARGE;
    }
  }
}

class WidgetsSize{
  ScreenConfigurations screenConfigurations;
  double small14;
  double small16;
  double small18;
  double small20;
  double small22;
  double small24;
  double small26;
  double small28;
  double smallIconRadius30;
  double smallIconRadiusCallUs20;
  double smallLogoIconRadius34;
  double smallLogoIconRadius45;
  double smallLogoIconRadius54;
  double spaceBetweenRowWidgets;
  double spaceBetweenColumnWidgets41;
  double spaceBetweenColumnWidgetsCallUs41;
  double spaceBetweenColumnWidgets10;
  double pointHeight;
  double spaceBetweenColumnIconsReverse;
  double widgetHeight;
  double transport;
  double singleProductAspectRatio;
  double singleProductHeight;
  double spaceBetweenColumnWidgetsSingleProduct10;
  double singleProductCardHeight;
  double smallLogoIconRadius80;
  double titlesListHeight;
  double homeButtonHeight;
  double mainScreenButtonsHeight;


  WidgetsSize(ScreenConfigurations screenConfigurations){
    this.screenConfigurations = screenConfigurations;
    _init();
  }

  void _init() {
    switch(this.screenConfigurations.screenType){

      case ScreenType.SMALL:
        this.small14 = 14;
        this.small16 = 16;
        this.small18 = 18;
        this.small20 = 20;
        this.small22 = 22;
        this.small24 = 24;
        this.small26 = 26;
        this.small28 = 28;
        this.smallIconRadius30 = 30;
        this.smallIconRadiusCallUs20 = 20;
        this.smallLogoIconRadius34 = 34;
        this.smallLogoIconRadius45 = 45;
        this.smallLogoIconRadius54 = 54;
        this.smallLogoIconRadius80 = 80;
        this.spaceBetweenRowWidgets = 0.6;
        this.widgetHeight = 0.75;
        this.spaceBetweenColumnIconsReverse = 0.68;
        this.spaceBetweenColumnWidgets41 = 0.006;
        this.spaceBetweenColumnWidgetsCallUs41 = 0.006;
        this.spaceBetweenColumnWidgets10 = 0.0015;
        this.spaceBetweenColumnWidgetsSingleProduct10 = 0.0015;
        this.pointHeight = 0.04;
        this.transport = 0.23;
        this.singleProductAspectRatio = 0.6;
        this.singleProductHeight = 0.3;
        this.singleProductCardHeight = 0.9;
        this.titlesListHeight = 0.2;
        this.homeButtonHeight = 0.385;
        this.mainScreenButtonsHeight =  0.13;
        break;

      case ScreenType.MEDIUM:
        this.small14 = 18;
        this.small16 = 20;
        this.small18 = 22;
        this.small20 = 24;
        this.small22 =26;
        this.small24 = 28;
        this.small26 = 30;
        this.small28 = 32;
        this.smallIconRadius30 = 32;
        this.smallIconRadiusCallUs20 = 30;
        this.smallLogoIconRadius34 = 44;
        this.smallLogoIconRadius45 = 50;
        this.smallLogoIconRadius54 = 60;
        this.smallLogoIconRadius80 = 100;
        this.spaceBetweenRowWidgets = 0.7;
        this.widgetHeight = 0.92;
        this.spaceBetweenColumnIconsReverse = 0.65;
        this.spaceBetweenColumnWidgets41 = 0.010;
        this.spaceBetweenColumnWidgetsCallUs41 = 0.010;
        this.spaceBetweenColumnWidgets10 = 0.002;
        this.spaceBetweenColumnWidgetsSingleProduct10 = 0.007;
        this.pointHeight = 0.02;
        this.transport = 0.28;
        this.singleProductAspectRatio = 0.6;
        this.singleProductHeight = 0.3;
        this.singleProductCardHeight = 0.65;
        this.titlesListHeight = 0.32;
        this.homeButtonHeight = 0.408;
        this.mainScreenButtonsHeight =  0.19;
        break;

      case ScreenType.LARGE:
        this.small14 = 20;
        this.small16 = 22;
        this.small18 = 24;
        this.small20 = 26;
        this.small22 = 28;
        this.small24 = 30;
        this.small26 = 32;
        this.small28 = 34;
        this.smallIconRadius30 = 36;
        this.smallIconRadiusCallUs20 = 45;
        this.smallLogoIconRadius34 = 54;
        this.smallLogoIconRadius45 = 60;
        this.smallLogoIconRadius54 = 65;
        this.smallLogoIconRadius80 = 130;
        this.spaceBetweenRowWidgets = 0.8;
        this.widgetHeight = 0.92;
        this.spaceBetweenColumnIconsReverse = 0.45;
        this.spaceBetweenColumnWidgets41 = 0.03;
        this.spaceBetweenColumnWidgetsCallUs41 = 0.01;
        this.spaceBetweenColumnWidgets10 = 0.035;
        this.spaceBetweenColumnWidgetsSingleProduct10 = 0.015;
        this.pointHeight = 0.01;
        this.transport = 0.3;
        this.singleProductAspectRatio = 0.85;
        this.singleProductHeight = 0.2;
        this.singleProductCardHeight = 0.65;
        this.titlesListHeight = 0.42;
        this.homeButtonHeight = 0.42;
        this.mainScreenButtonsHeight =  0.25;
        break;
    }
  }
}

