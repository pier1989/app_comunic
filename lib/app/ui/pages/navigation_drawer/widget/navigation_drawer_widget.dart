import 'package:app_comunic/app/my_app.dart';
import 'package:app_comunic/app/ui/pages/camra/camera.dart';
import 'package:app_comunic/app/ui/pages/gestionar_ubicacion/add_geolocalizacion.dart';
import 'package:app_comunic/app/ui/pages/gestionar_ubicacion/list_geolocalizacion.dart';
import 'package:app_comunic/app/ui/pages/gestionar_ubicacion/loc/loc.dart';
import 'package:app_comunic/app/ui/pages/home/tabs/profile/profile_tabs.dart';
import 'package:app_comunic/app/ui/pages/list/insert_screen.dart';
import 'package:app_comunic/app/ui/pages/list/list_averia/search_screen.dart';
import 'package:app_comunic/app/ui/pages/list/list_averias.dart';
import 'package:app_comunic/app/ui/pages/register/register_pages.dart';
import 'package:app_comunic/app/ui/pages/register_averia/register_averia_page.dart';
import 'package:app_comunic/app/ui/pages/register_telefono/register_telefono_page.dart';
import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    final name = 'Sarah Abs';
    final email = 'sarah@abs.com';
    final urlImage =
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

    return Drawer(
      child: Material(
        color: Color.fromRGBO(70, 75, 90, 1),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assets/images/dark/klo.jpg"), // <-- BACKGROUND IMAGE
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: <Widget>[
              buildHeader(
                // final cold =const Color.fromRGBO(70, 75, 205, 1),
                urlImage: urlImage,
                name: name,
                email: email,
                onClicked:
                    () {}, //=> Navigator.of(context).push(MaterialPageRoute(
                // builder: (context) => UserPage(
                //  name: 'Sarah Abs',
                //   urlImage: urlImage,
                //  ),
                // )),
              ),
              Container(
                color: const Color.fromRGBO(70, 75, 205, 1),
                padding: padding,
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    // buildSearchField(),
                    const SizedBox(height: 24),
                    buildMenuItem(
                      text: 'Mi Programacion',
                      icon: Icons.report,
                      onClicked: () => selectedItem(context, 0),
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: 'Reportar Averia',
                      icon: Icons.support_agent,
                      onClicked: () => selectedItem(context, 1),
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: 'Registrar Terminal',
                      icon: Icons.phone_callback,
                      onClicked: () => selectedItem(context, 2),
                    ),
                    const SizedBox(height: 24),
                    Divider(color: Colors.white70),
                    const SizedBox(height: 24),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: 'Localizar Terminal',
                      icon: Icons.location_city,
                      onClicked: () => selectedItem(context, 3),
                    ),
                    buildMenuItem(
                      text: 'Consolidado de Averias',
                      icon: Icons.report_problem,
                      onClicked: () => selectedItem(context, 4),
                    ),
                    const SizedBox(height: 24),
                    Divider(color: Colors.white70),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: 'Logout',
                      icon: Icons.notifications_outlined,
                      onClicked: () => selectedItem(context, 5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              Spacer(),
              CircleAvatar(
                //globo mas
                radius: 24,
                backgroundColor: Color.fromRGBO(30, 60, 168, 1),
                child: Icon(Icons.logout, color: Colors.white),
              )
            ],
          ),
        ),
      );

  Widget buildSearchField() {
    final color = Colors.white;

    return TextField(
      style: TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Search',
        hintStyle: TextStyle(color: color),
        prefixIcon: Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    final col = const Color.fromRGBO(10, 75, 105, 1),
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SearchUi(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ProfileTab(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RegisterAveria(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FireMap(),
          // MyApplist(),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MapLocation(),
        ));
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MapList(),
        ));
        break;
    }
  }
}
