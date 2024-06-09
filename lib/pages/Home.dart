import 'dart:convert';

import 'package:ebook_ui/Colors/app_colors.dart' as AppColors;
import 'package:ebook_ui/widgets/FirstTabView.dart';
import 'package:ebook_ui/widgets/my_tabs.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  List? PopularBooks;
  List? Books;
//..Scroll Controller will be used for Overall Scroll
  ScrollController? _scrollController;
  // Tab Controller will be used for Categories buttons
  TabController? _tabController;

  ReadDataJson() {
    // For pageView Builder
     DefaultAssetBundle.of(context)
        .loadString("json/popularBooks.json")
        .then((loadedValue) {
      setState(() {
        PopularBooks = json.decode(loadedValue);
      });
    });

    /// For List View Builder
    DefaultAssetBundle.of(context)
        .loadString("json/books.json")
        .then((loadedValue) {
      setState(() {
        Books = json.decode(loadedValue);
      });
    });
  }

  @override
  void initState() {
    ReadDataJson();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.background,
        child: SafeArea(
            child: Scaffold(
          body: Column(
            children: [
              // Upper Area Design Till Books View Slider
              // Data in Books is from JSON files that we add in assets
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.menu_outlined),
                    Row(
                      children: [
                        Icon(Icons.notifications),
                        SizedBox(
                          width: 12,
                        ),
                        Icon(Icons.search),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: const Text(
                      "Popular Posts",
                      style: TextStyle(fontSize: 30),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Container(
                height: 200,
                child: Stack(
                  children: [
                    Positioned(
                        left: -25,
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          height: 200,
                          child: PageView.builder(
                            allowImplicitScrolling: true,
                            itemCount:6,
                                // PopularBooks == null ? 0 : PopularBooks!.length,
                            controller: PageController(viewportFraction: 0.8),
                            itemBuilder: (context, index) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.only(right: 10),
                                height: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                           PopularBooks![index]['img']))),
                              );
                            },
                          ),
                        )),
                  ],
                ),
              ),

              // Below Scrollable Area
              // Menues, or Anyother Items

              Expanded(
                  child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      pinned: true,
                      bottom: PreferredSize(
                          preferredSize: Size.fromHeight(50),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(bottom: 20, left: 10),
                            child: TabBar(
                                indicatorPadding: EdgeInsets.only(left: 0),
                                indicatorSize: TabBarIndicatorSize.label,
                                labelPadding:
                                    EdgeInsets.only(right: 10, left: 8),
                                controller: _tabController,
                                indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 7,
                                          // First value in offset indicate left/right
                                          // Second in offset indicate up/down

                                          offset: Offset(0, 0))
                                    ]),
                                tabs: [
                                  AppTab(title: "New", color: Colors.green),

                                  // 2
                                  AppTab(title: "Popular", color: Colors.red),
                                  //3
                                  AppTab(
                                      title: "Trending", color: Colors.amber),
                                ]),
                          )),
                    ),
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    // First Page of Tab will Show this
                    ListView.builder(
                      itemCount: Books?.length == 0 ? null : Books?.length,
                      itemBuilder: (context, index) {
                      // Creating variable which can save all data as per index then i can send this to FirstTab
                        final BooksData = Books?[index];

                        // We Created Another FirstTab Widget file
                        return FirstTab(
                            listLength: Books?.length,
                            Rating: BooksData["rating"],
                            ImageURL: BooksData["img"],
                            Title: BooksData["title"],
                            Subtitle: BooksData["text"]

                            // listLength:6,
                            // Rating: "Rating",
                            // ImageURL: "https://images-platform.99static.com//zQeGI0WjBgrLZmz1nyINDpuQOSQ=/0x0:2456x2456/fit-in/500x500/projects-files/105/10587/1058794/b7d27192-8999-4d77-8770-dcdd19b80970.jpg",
                            // Title: "NewYork",
                            // Subtitle: "Muslims Book"
                        );
                      },
                    ),

                    Material(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text("Content"),
                      ),
                    ),
                    Material(
                        child:Text("Loading......")),
                  ],
                ),
              ))
            ],
          ),
        )));
  }
}
