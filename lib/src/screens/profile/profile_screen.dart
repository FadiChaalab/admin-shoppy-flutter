import 'dart:typed_data';

import 'package:admin_shop/src/components/arrow_widget.dart';
import 'package:admin_shop/src/components/headline_2_title.dart';
import 'package:admin_shop/src/components/headline_title.dart';
import 'package:admin_shop/src/components/image_profile.dart';
import 'package:admin_shop/src/db/storage.dart';
import 'package:admin_shop/src/screens/settings/components/edit_profile_form.dart';
import 'package:admin_shop/src/utils/constante.dart';
import 'package:admin_shop/src/utils/utils.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Uint8List image;
  final _storage = StorageRepo();

  uploadImage(Uint8List img) async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      await _storage.uploadProfilePicture(img);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            AppLocalizations.of(context)!.offline,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 70),
          const SizedBox(height: kDefaultPadding),
          const HeadlineTitle(title: 'Profile'),
          const SizedBox(height: kDefaultPadding / 2),
          Row(
            children: const [
              SubTitle(title: 'Shoppy'),
              SizedBox(width: kDefaultPadding / 2),
              ArrowWidget(),
              SizedBox(width: kDefaultPadding / 2),
              SubTitle(title: 'Profile'),
            ],
          ),
          const SizedBox(height: kDefaultPadding * 2),
          ImageProfile(
            width: 84,
            iconContainer: 32,
            icon: 'assets/icons/Camera.svg',
            onTap: () async {
              var pickedFile = await pickImage(ImageSource.gallery);
              if (pickedFile != null) {
                image = pickedFile;
                uploadImage(image);
              }
            },
          ),
          const SizedBox(
            height: kDefaultPadding * 2,
          ),
          const EditProfileForm(),
          const SizedBox(
            height: kDefaultPadding * 6,
          ),
        ],
      ),
    );
  }
}
