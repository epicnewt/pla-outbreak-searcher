import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmo_searcher/common/feature_switches.dart';
import 'package:mmo_searcher/navigator.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var moEnabled = FeatureSwitchService.provide().isMassOutbreakPathingEnabled();
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const DrawerHeader(
            child: Text(
              "Pokémon Legends Arcues RNG Tools",
              style: TextStyle(
                color: Colors.white,
                shadows: [
                  Shadow(offset: Offset(0, 0), blurRadius: 15),
                ],
              ),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: AssetImage("assets/images/drawer-header.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (moEnabled)
            ListTile(
              selected: ModalRoute.of(context)?.settings.name?.startsWith("mo-") ?? false,
              title: const Text("v1.0.2"),
              onTap: () {
                AppRouteNavigator.provide().toMOSearch(context);
              },
            ),
          if (moEnabled)
            ListTile(
              selected: ModalRoute.of(context)?.settings.name?.startsWith("mmo-") ?? false,
              title: const Text("v1.1.1"),
              onTap: () {
                ModalRoute.of(context)?.isCurrent;
                AppRouteNavigator.provide().toMMOSearch(context);
              },
            ),
          Expanded(child: Container()),
          ListTile(
            selected: false,
            title: const Text("About"),
            leading: const FaIcon(FontAwesomeIcons.circleQuestion),
            onTap: () async {
              var info = await PackageInfo.fromPlatform();

              showAboutDialog(context: context, applicationName: info.appName, applicationVersion: '${info.version} #${info.buildNumber}', children: [
                const Text("This app provides tools for taking advantage of RNG exploits in Pokémon Legends Arceus"),
                const Text(""),
                const Text("Credit should go to Cappy, Linlon-LM and AdamJ who have researched the methods and pointers that are used by this application."),
                const Text(""),
                const Text("Disclaimer: None of the authors, contributors or anyone else connected with this app, can be held responsible for an damages to your Nintendo Switch or the banning of your system from Nintendo Online services, or any other damages. By using this application you accept these risks."),
                const Text(""),
                const Text("If you find this useful and would like to help support the further development of this app then please feel free to"),
                GestureDetector(
                  onTap: () async {
                    var url = Uri.parse("https://www.buymeacoffee.com/EpicNewt");
                    if (await canLaunchUrl(url)) {
                      launchUrl(url);
                    }
                  },
                  child: Image.asset(
                    "assets/images/bmac.png",
                    width: 200,
                    height: 150,
                  ),
                )
              ]);
            },
          )
        ],
      ),
    );
  }
}
