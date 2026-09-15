import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(length: 4, child: TabsDemo()),
    );
  }
}

class TabsDemo extends StatefulWidget {
  const TabsDemo({super.key});

  @override
  State<TabsDemo> createState() => _TabsDemoState();
}

class _TabsDemoState extends State<TabsDemo>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final tabs = ['Tab 1', 'Tab 2', 'Tab 3', 'Tab 4'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Tabs Demo'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          tabs: [for (final tab in tabs) Tab(text: tab)],
        ),
      ),

      bottomNavigationBar: const BottomAppBar(
        child: SizedBox(
          height: 50,
          child: Center(
            child: Text(
              'My Flutter Tab App',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: [
          Container(
            color: Colors.lightBlue.shade100,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome to Tab 1!',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Hello!'),
                            content: const Text(
                              'This is an AlertDialog from Tab 1.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Open Alert'),
                  ),
                ],
              ),
            ),
          ),

          Container(
            color: Colors.purple.shade100,
            padding: const EdgeInsets.all(20),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://commons.wikimedia.org/wiki/Special:Redirect/file/Pteranodon.jpg',
                      width: 250,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 25),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'Your Name',
                        hintText: 'Enter your name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Container(
            color: Colors.orange.shade100,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Button pressed in ${tabs[2]} tab!'),
                    ),
                  );
                },
                child: const Text('Click me'),
              ),
            ),
          ),

          Container(
            color: Colors.green.shade100,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.school),
                    title: Text('Item 1'),
                    subtitle: Text('Details for item 1'),
                  ),
                ),
                Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.book),
                    title: Text('Item 2'),
                    subtitle: Text('Details for item 2'),
                  ),
                ),
                Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.star),
                    title: Text('Item 3'),
                    subtitle: Text('Details for item 3'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
