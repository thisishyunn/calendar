import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int initialIdx = 100;
  final PageController _pageController = PageController(initialPage: 100);
  int startOfWeek = 7;
  DateTime thisMonth = DateTime.now();
  late DateTime prevMonth, nextMonth;
  late List<String> dayBar;

  @override
  void initState() {
    List<String> l = [
      '월',
      '화',
      '수',
      '목',
      '금',
      '토',
      '일',
      '월',
      '화',
      '수',
      '목',
      '금',
      '토'
    ];
    dayBar = List.generate(7, (i) => l[startOfWeek + i - 1]);
    prevMonth = DateTime(thisMonth.year, thisMonth.month - 1);
    nextMonth = DateTime(thisMonth.year, thisMonth.month + 1);
    super.initState();
  }

  int rowNum(DateTime tm) {
    DateTime(tm.year, tm.month, 1).weekday;
    int push = (DateTime(tm.year, tm.month, 1).weekday - startOfWeek) % 7;
    int z = DateTime(tm.year, tm.month + 1, 0).day;
    if (push + z % 7 == 0) return 4;
    if (push + z % 7 < 8) return 5;
    return 6;
  }

  DateTime thisDay(DateTime dt, int i, int j) {
    int day =
        -((DateTime(dt.year, dt.month, 1).weekday - startOfWeek) %
                7) +
            7 * i +
            j +
            1;
    return DateTime(dt.year, dt.month, day);
  }

  Widget dayBlock(DateTime d) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 7 - 10,
          height: 60,
          // color: Colors.lightBlue,
          alignment: Alignment.topCenter,
          child: Text(
            d.day.toString(),
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              thisMonth.year.toString() + "." + thisMonth.month.toString(),
              style: TextStyle(fontSize: 30),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              color: Colors.greenAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(7, (idx) => Text(dayBar[idx])),
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.6,
                // color: Colors.green,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  itemBuilder: (_, idx) {
                    DateTime dt = DateTime(DateTime.now().year, DateTime.now().month-initialIdx+idx);
                    return Center(
                      child: Table(
                        children: List.generate(
                            rowNum(dt),
                            (i) => TableRow(
                                children: List.generate(
                                    7,
                                    (j) => Center(
                                        child: dayBlock(thisDay(dt, i, j)))))),
                      ),
                    );
                  },
                  onPageChanged: (i) {
                    setState(() {
                      thisMonth = DateTime(DateTime.now().year,
                          DateTime.now().month - initialIdx + i);
                    });
                  },
                )),
          ],
        ),
      ),
    );
  }
}
