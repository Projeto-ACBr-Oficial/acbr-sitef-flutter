import 'package:fintesthub_flutter/ui/payment/payment_page.dart';
import 'package:fintesthub_flutter/ui/settings/settings_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[PaymentPage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedIndex: _selectedIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.credit_card),
            label: 'Pagamento',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
      ),
      body: _pages.elementAt(_selectedIndex),
    );
  }
}
