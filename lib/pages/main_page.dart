import 'package:faker/faker.dart' as faker;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/models/moments.dart';
import 'package:myapp/pages/home_page.dart';
import 'package:myapp/pages/moment_create_page.dart';
import 'package:myapp/pages/search_page.dart';
import 'package:myapp/resources/colors.dart';
import 'package:nanoid2/nanoid2.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Variabel untuk menyimpan index halaman yang aktif
  int _selectedPageIndex = 0;

  final _faker = faker.Faker();
  // List moment
  List<Moment> moments = [];

  // Fungsi untuk mengubah index halaman yang aktif
  void _onPageChanged(int index) {
    if (index == 2) {
      //Navigasi ke halaman create moment
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return MomentCreatePage(onSaved: _addMoment);
      }));
    } else {
      //JIka tidak index 2, ke halaman yang sesuai
      setState(() {
        _selectedPageIndex = index;
      });
    }
  }
  
  @override
  void initState() {
    super.initState();
    moments = List.generate(
      2,
      (index) => Moment(
        id: nanoid(),
        momentDate: _faker.date.dateTime(),
        creator: _faker.person.name(),
        location: _faker.address.city(),
        imageUrl: 'https://picsum.photos/800/600?random=$index',
        caption: _faker.lorem.sentence(),
        likeCount: faker.random.integer(1000),
        commentCount: faker.random.integer(100),
        bookmarkCount: faker.random.integer(50),
      ),
    );
  }

  void _addMoment(Moment newMoment) {
    setState(() {
      moments.add(newMoment);
    });
  }
  @override
  Widget build(BuildContext context) {
  // List halaman yang tersedia
    final List<Widget> pages = [
      HomePage(moments: moments),
      const SearchBarApp(),
      const Center(
        child: Text('Create Moment'),
      ),
      const Center(
        child: Text('Activity'),
      ),
      const Center(
        child: Text('Profile'),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/moments_text.png',
          height: 32,
        ),
        centerTitle: true,
      ),
      body: pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/fi-br-home.svg'),
            activeIcon: SvgPicture.asset(
              'assets/icons/fi-sr-home.svg',
              colorFilter:
                  const ColorFilter.mode(primaryColor, BlendMode.srcIn),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/fi-br-search.svg'),
            activeIcon: SvgPicture.asset(
              'assets/icons/fi-sr-search.svg',
              colorFilter:
                  const ColorFilter.mode(primaryColor, BlendMode.srcIn),
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/fi-br-add.svg'),
            activeIcon: SvgPicture.asset(
              'assets/icons/fi-sr-add.svg',
              colorFilter:
                  const ColorFilter.mode(primaryColor, BlendMode.srcIn),
            ),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/fi-br-heart.svg'),
            activeIcon: SvgPicture.asset(
              'assets/icons/fi-sr-heart.svg',
              colorFilter:
                  const ColorFilter.mode(primaryColor, BlendMode.srcIn),
            ),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/fi-br-portrait.svg'),
            activeIcon: SvgPicture.asset(
              'assets/icons/fi-sr-portrait.svg',
              colorFilter:
                  const ColorFilter.mode(primaryColor, BlendMode.srcIn),
            ),
            label: 'Profile',
          ),
        ],
        selectedItemColor: primaryColor,
        unselectedItemColor: secondaryColor,
        onTap: _onPageChanged,
        currentIndex: _selectedPageIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}