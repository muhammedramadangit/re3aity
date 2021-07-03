import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/ConfirmForgetPassword/Bloc/ProviderConfirmForgetCubit.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/Forget_Password/Bloc/Cubit.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/NewPassword/bloc/ProviderNewPassCubit.dart';
import 'package:lastre3ayty/Splash/splash_screen.dart';
import 'package:lastre3ayty/re3aytiii/SignUp/Signup.dart';
import 'package:lastre3ayty/theme/color.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/CompleteRegister/bloc/CompleteRegisterCubit.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/Confim_Code/Bloc/VerifyCubit.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/Login/Bloc/ProviderLoginCubit.dart';
import 'package:lastre3ayty/Provider/Screens/Auth/SignUp/Bloc/cubit.dart';
import 'package:lastre3ayty/Provider/Screens/Provider_Profile/Bloc/ProviderProfileCubit.dart';
import 'package:lastre3ayty/User/screens/Auth/Confim_Code/bloc/ConfirmCodeCubit.dart';
import 'package:lastre3ayty/User/screens/Auth/Confirm_Forget_Password/Bloc/Confirm_Forget_Cubit.dart';
import 'package:lastre3ayty/User/screens/Auth/Forget_Password/Bloc/Forget_Pass_Cubit.dart';
import 'package:lastre3ayty/User/screens/Auth/NewPassword/Bloc/NewPass_Cubit.dart';
import 'package:lastre3ayty/User/screens/Auth/SignUp/Bloc/Cubit.dart';
import 'package:lastre3ayty/User/screens/Doctors/Bloc/AddReservationCubit.dart';

import 'User/screens/Auth/Login/Bloc/Cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //=========== user Bloc ================
        BlocProvider(create: (_) => LoginCubit()),
        BlocProvider(create: (_) => SignUpCubit()),
        BlocProvider(create: (_) => ConfirmCodeCubit()),
        BlocProvider(create: (_) => ForgetPassCubit()),
        BlocProvider(create: (_) => NewPassCubit()),
        BlocProvider(create: (_) => ConfirmForgetCubit()),

        //=========== provider Bloc ================
        BlocProvider(create: (_) => ProviderLoginCubit()),
        BlocProvider(create: (_) => ProviderSignUpCubit()),
        BlocProvider(create: (_) => ProviderVerifyCubit()),
        BlocProvider(create: (_) => CompleteRegisterCubit()),
        BlocProvider(create: (_) => ProviderForgetCubit()),
        BlocProvider(create: (_) => ProviderConfirmForgetCubit()),
        BlocProvider(create: (_) => ProviderNewPassCubit()),

        BlocProvider(create: (_) => AddReservationCubit()),

        BlocProvider(create: (_) => ProviderProfileCubit()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'رعايتي',
        theme: ThemeData(
          primaryColor: ThemeColor.mainPurple,
          accentColor: ThemeColor.lighterGreyText,
          fontFamily: "Cairo-Regular",
        ),
        // home: CompleteRegisterDataScreen(),
        home: SplashScreen(),
      ),
    );
  }
}



