import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:habit_trail_flutter/pages/awards.dart';
import 'package:habit_trail_flutter/pages/profile.dart';
import 'package:habit_trail_flutter/pages/score.dart';
import 'package:habit_trail_flutter/pages/tasks.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 3;
  List<StatelessWidget> tabs = const [
    TasksPage(),
    AwardsPage(),
    ScorePage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  void onTabTapped(int index) async {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TDNavBar(
        height: 48,
        titleFontWeight: FontWeight.w600,
        title: "好习惯",
        useDefaultBack: false,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        backgroundColor: Colors.blue, // 设置背景颜色
        selectedItemColor: Colors.white, // 设置选中项的颜色
        unselectedItemColor: Colors.white70, // 设置未选中项的颜色
        type: BottomNavigationBarType.fixed, // 设置底部导航栏类型
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.task), label: "任务"),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "奖惩"),
          BottomNavigationBarItem(icon: Icon(Icons.loyalty), label: "积分"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的"),
        ],
      ),
    );
  }
}
