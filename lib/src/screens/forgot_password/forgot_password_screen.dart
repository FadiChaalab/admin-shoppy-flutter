import 'package:admin_shop/src/components/footer.dart';
import 'package:admin_shop/src/responsive/responsive_layout.dart';
import 'package:admin_shop/src/screens/forgot_password/components/desktop_body.dart';
import 'package:flutter/material.dart';
import 'components/mobile_body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

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
