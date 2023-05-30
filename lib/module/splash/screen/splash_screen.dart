import 'package:brg_management/module/splash/view_model/splash_vm.dart';
import 'package:brg_management/resources/asset_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashViewModel viewModel;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      viewModel = Provider.of<SplashViewModel>(context, listen: false);
      viewModel.initData();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bg_splash_new),
              fit: BoxFit.fill,
            ),
          ),
          child: Consumer<SplashViewModel>(
            builder: (context, vm, child) => Container(),
          ),
        ),
      ),
    );
  }
}
