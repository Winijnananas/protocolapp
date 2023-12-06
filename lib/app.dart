import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Protocol App',
      theme: ThemeData(useMaterial3: true),
      home: NavigationExample(),
    );
  }
}

class NavigationExample extends StatefulWidget {
  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.camera),
            icon: Icon(Icons.camera_alt_outlined),
            label: 'Camera',
          ),
          // NavigationDestination(
          //   selectedIcon: Badge(child: Icon(Icons.notifications_sharp)),
          //   icon: Badge(child: Icon(Icons.notifications_sharp)),
          //   label: 'Notifications',
          // ),
          NavigationDestination(
            selectedIcon: Badge(
              label: Text('2'),
              child: Icon(Icons.messenger_sharp),
            ),
            icon: Badge(
              label: Text('2'),
              child: Icon(Icons.messenger_sharp),
            ),
            label: 'Messages',
          ),
        ],
      ),
      body: <Widget>[
        // หน้า Camera
        CameraScreen(),

        // หน้า Notifications
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('notifications 1'),
                  subtitle: Text('debug is running'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('notifications 2'),
                  subtitle: Text('test services'),
                ),
              ),
            ],
          ),
        ),

        // หน้า Messages
        ListView.builder(
          reverse: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'สวัสดี',
                    style: theme.textTheme.bodyText1!
                        .copyWith(color: theme.colorScheme.onPrimary),
                  ),
                ),
              );
            }
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'หวัดดี!',
                  style: theme.textTheme.bodyText1!
                      .copyWith(color: theme.colorScheme.onPrimary),
                ),
              ),
            );
          },
        ),
      ][currentPageIndex],
    );
  }
}

class NavigationDestination extends StatelessWidget {
  const NavigationDestination({
    Key? key,
    required this.selectedIcon,
    this.icon,
    required this.label,
  }) : super(key: key);

  final Widget selectedIcon;
  final Widget? icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: icon ?? selectedIcon,
      subtitle: Text(label),
    );
  }
}

class Badge extends StatelessWidget {
  const Badge({Key? key, required this.child, this.label}) : super(key: key);

  final Widget child;
  final Widget? label;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        if (label != null) Positioned(top: 2, right: 2, child: label!),
      ],
    );
  }
}

class NavigationBar extends StatelessWidget {
  const NavigationBar({
    Key? key,
    required this.onDestinationSelected,
    required this.indicatorColor,
    required this.selectedIndex,
    required this.destinations,
  }) : super(key: key);

  final ValueChanged<int> onDestinationSelected;
  final Color indicatorColor;
  final int selectedIndex;
  final List<Widget> destinations;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BottomNavigationBar(
      onTap: onDestinationSelected,
      currentIndex: selectedIndex,
      selectedItemColor: indicatorColor,
      items: destinations.map((destination) {
        return BottomNavigationBarItem(
          icon: destination,
          label: '',
          backgroundColor: colorScheme.background,
        );
      }).toList(),
    );
  }
}

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;

  @override
  void initState() {
    super.initState();
    availableCameras().then((cameras) {
      _controller = CameraController(cameras[0], ResolutionPreset.medium);
      _controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
      ),
      body: CameraPreview(_controller),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            final image = await _controller.takePicture();
            // Do something with the captured image
          } catch (e) {
            print("Error taking picture: $e");
          }
        },
      ),
    );
  }
}
