import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;
import 'package:tafeel_task/provider/user_provider.dart';
import 'package:tafeel_task/utils/navigation.dart';
import 'package:tafeel_task/view/widgets/app_bar.dart';

import '../../../utils/color_resources.dart';
import '../../../utils/images.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      extendBody: true,
      appBar: CustomAppBar(title: 'User Profile' ,isLeftIcon: true,onPressedLeft: (){
        AppNavigation.navigatePOP(context);
      },),
      extendBodyBehindAppBar: true,
      body: Provider.of<UserProvider>(context, listen: true).isLoading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
            child: Center(
              child: Card(
                margin: EdgeInsets.only(bottom: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                         CircleAvatar(
                          backgroundImage:  Provider.of<UserProvider>(
                            context,
                            listen: false,
                          ).userDataModel!.avatar==null?AssetImage(Images.logo):NetworkImage(
                            Provider.of<UserProvider>(
                              context,
                              listen: false,
                            ).userDataModel!.avatar!,
                          ),
                          radius: 50,
                        ),
                        SizedBox(height: 16),
                        Text(
                          "${Provider.of<UserProvider>(context, listen: false).userDataModel!.firstName} ${Provider.of<UserProvider>(context, listen: false).userDataModel!.lastName}",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          Provider.of<UserProvider>(
                            context,
                            listen: false,
                          ).userDataModel!.email??'',
                          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                ),
            ),
          ),
    );
  }
}
