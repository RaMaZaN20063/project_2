import 'package:flutter/material.dart';
import 'package:realization_project/pages/active_page.dart';
import 'package:realization_project/pages/canceled_page.dart';
import 'package:realization_project/pages/completed_page.dart';

class InformationTaxi extends StatefulWidget {
  const InformationTaxi({super.key});

  @override
  State<InformationTaxi> createState() => _InformationTaxiState();
}

class _InformationTaxiState extends State<InformationTaxi> with SingleTickerProviderStateMixin {
 late TabController _tabController;
 int _selectedIndex = 0;
 
 @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
      // Следим за изменением вкладки
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color.fromARGB(255, 16, 70, 96),
      appBarTheme: AppBarTheme(backgroundColor: const Color.fromARGB(255, 16, 70, 96),)
      ),
        home: DefaultTabController(length: 3, child:  
         Scaffold(
        appBar: AppBar(
          title: Text('My Bookings'),
          centerTitle: true,
          bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.green,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.green,
            indicatorWeight: 3,
            tabs: [
            Tab(child: Text('Active Now', style: TextStyle(fontWeight: FontWeight.bold, color: _selectedIndex == 0 ? Colors.green : Colors.grey),)),
            Tab(child: Text('Completed', style: TextStyle(fontWeight: FontWeight.bold, color: _selectedIndex == 1 ? Colors.green : Colors.grey),)),
            Tab(child: Text('Cancelled', style: TextStyle(fontWeight: FontWeight.bold, color: _selectedIndex == 2 ? Colors.green : Colors.grey),)),
          ]),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
          ActivePage(),
          CompletedPage(driverName: '', carNumber: '', driverImageUrl: '',),
          CanceledPage(),
        ]),
      ),
    ),);
  }
}
