import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: _TabsNonScrollableDemo(),
      ),
    );
  }
}

class _TabsNonScrollableDemo extends StatefulWidget {
  @override
  __TabsNonScrollableDemoState createState() => __TabsNonScrollableDemoState();
}

class __TabsNonScrollableDemoState extends State<_TabsNonScrollableDemo>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;

  final RestorableInt tabIndex = RestorableInt(0);

  @override
  String get restorationId => 'tab_non_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );

    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ['Tab 1', 'Tab 2', 'Tab 3', 'Tab 4'];
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Tabs Demo',
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          tabs: [
            for (final tab in tabs) Tab(text: tab),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1 — Styled Text + AlertDialog
          Container(
            color: colors[0],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to ${tabs[0]}!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          return AlertDialog(
                            title: const Text('Alert Dialog'),
                            content: const Text(
                              'This is an AlertDialog in Tab 1.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Show Alert'),
                  ),
                ],
              ),
            ),
          ),

          // Tab 2 — Image + TextField
          Container(
            color: colors[1],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    'https://imgs.search.brave.com/F5cv1jGqLkdJLfD5uPcK3I8gb2Td2BVxB0CTC2HHwGI/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zdGF0/aWMudmVjdGVlenku/Y29tL3N5c3RlbS9y/ZXNvdXJjZXMvdGh1/bWJuYWlscy8wNDgv/NDQ3Lzg2Ny9zbWFs/bC9jdXRlLWtpdHRl/bi1zbGVlcGluZy15/YXduaW5nLWFuZC1s/YXppbmctb24tYS13/aGl0ZS1yYXNmdXIt/Y2FycGV0LWludGVy/bmF0aW9uYWwtY2F0/LWRheS1jb25jZXB0/LXBob3RvLmpwZw',
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Enter text',
                        hintText: 'Type something here',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Tab 3 — Button + SnackBar
          Container(
            color: colors[2],
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${tabs[2]} button was clicked!',
                      ),
                    ),
                  );
                },
                child: const Text('Click me'),
              ),
            ),
          ),

          // Tab 4 — ListView + Cards
          Container(
            color: colors[3],
            child: ListView(
              children: [
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.star),
                    title: const Text('Item 1'),
                    subtitle: const Text('This is the first item.'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.favorite),
                    title: const Text('Item 2'),
                    subtitle: const Text('This is the second item.'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Item 3'),
                    subtitle: const Text('This is the third item.'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
      ),
    );
  }
}
