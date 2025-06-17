import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tafeel_task/provider/user_provider.dart';
import 'package:tafeel_task/utils/color_resources.dart';
import 'package:tafeel_task/utils/navigation.dart';
import 'package:tafeel_task/view/screen/user_data/user_data_screen.dart';
import 'package:tafeel_task/view/widgets/app_bar.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int currentPage = 3;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      currentPage++;
      await Provider.of<UserProvider>(
        context,
        listen: false,
      ).getUserListApi(context: context, currentPage: currentPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      extendBody: true,
      appBar: CustomAppBar(
        title: 'List User',
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Consumer<UserProvider>(
          builder: (context, provider, child) {
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:
                  provider.listUserModel!.length + (provider.isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == provider.listUserModel!.length) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final user = provider.listUserModel![index];
                return InkWell(
                  onTap: ()async{
                     Provider.of<UserProvider>(
                      context,
                      listen: false,
                    ).getUserDataApi(context: context, idUser: user.id);

                    AppNavigation.navigateTo(context, UserDataScreen());
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500 + (index * 100)),
                    curve: Curves.easeInOut,
                    margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.shade200, blurRadius: 6),
                      ],
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.avatar!),
                      ),
                      title: Text("${user.firstName} ${user.lastName}"),
                      subtitle: Text(user.email!),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
