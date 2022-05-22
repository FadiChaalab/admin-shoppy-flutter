import 'package:admin_shop/src/components/footer.dart';
import 'package:admin_shop/src/responsive/responsive_layout.dart';
import 'package:admin_shop/src/screens/sign_in/components/desktop_body.dart';
import 'package:flutter/material.dart';
import 'components/mobile_body.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResponsiveLayout(
        mobile: MobileBody(),
        tablet: DesktopBody(),
        desktop: DesktopBody(),
      ),
      bottomNavigationBar: Footer(),
    );
  }
}
