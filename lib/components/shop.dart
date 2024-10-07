import 'dart:math';
import '/components/shimmer.dart';
import '/footers/desktop_footer.dart';
import '/footers/tablet_footer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../controller/controller.dart';
import '../controller/dbfields.dart';
import '../widgets/featured_product.dart';
import '../widgets/featuredgridview.dart';
import '../widgets/main_menu.dart';
import '../widgets/menu_type.dart';
import '../widgets/route.dart';
import '../widgets/side_menu.dart';
import '../widgets/social_media_icons.dart';
import 'global.dart';


class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  bool show=false;
  List<String> urls=[];
  List<Widget> myimage = [];
  String searchQuery = '';

  String shoenum="";
  List<bool> active=[];
  final searchController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = 300.0;

    bool isVisible () {
      double screenWidth = MediaQuery.of(context).size.width;
      return screenWidth > 1200;
    }
    bool isNotVisible () {
      double screenWidth = MediaQuery.of(context).size.width;
      return screenWidth < 1200;
    }


    int crossAxisCount = (screenWidth ~/ itemWidth).clamp(2, 6);
    //int crossAxisCount = (screenWidth / itemWidth).floor();
    // if (screenWidth <= 400) {
    //   crossAxisCount = 1;
    // }
    // else if (screenWidth <= 600 && screenWidth<800) {
    //   crossAxisCount = (screenWidth / 400).floor();
    // }
    // else if(screenWidth >=600 && screenWidth<1000)
    // {
    //   crossAxisCount = (screenWidth / 230).floor();
    //
    // }
    //
    // if (crossAxisCount <= 1) {
    //   crossAxisCount = 1;
    // }

    return Consumer<Ecom>(
      builder: (BuildContext context, value, Widget? child) {
        if(value.selectedcategory.isNotEmpty){
          searchQuery=value.selectedcategory;
        }
        return Scaffold(
          appBar: AppBar(
            //toolbarHeight: 100,
            title: Visibility(
              visible: isVisible(),
              child: Container(
                width: double.infinity,
                height: 50,
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          MainMenu()
                        ],
                      ),
                      const SizedBox(width: 120),
                      // Row(
                      //   children: [
                      //     SizedBox(
                      //       height: 50,
                      //       width: 400,
                      //       child: Column(
                      //         children: [
                      //           TextField(
                      //             controller: searchController,
                      //             onChanged: (txt){
                      //               setState(() {
                      //                 searchQuery=txt;
                      //
                      //               });
                      //             },
                      //             decoration: const InputDecoration(
                      //                 hintText: 'Search by Item name,category or price?',
                      //                 hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                      //                 fillColor: Colors.white54,
                      //                 filled: true
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //     Container(
                      //       height: 50,
                      //       width: 150,
                      //       color: Global.mainColor,
                      //       child: const Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Text("Search", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(width: 120),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                              onTap: (){
                                Navigator.pushNamed(context, Routes.singleProduct);
                              },
                              child: const Icon(Icons.favorite)
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                              onTap: ()async{
                                await value.cartidmethod();
                                final st=await value.alreadypaid(context);
                                Navigator.pushNamed(context, Routes.cart);
                              },
                              child: const Icon(Icons.shopping_cart)
                          ),
                          const SizedBox(width: 8),
                          Text("Total: USD ${value.mycarttotal}",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.lightBlue[50],
            automaticallyImplyLeading: isNotVisible(),
          ),
          drawer: Visibility(
              visible: isNotVisible(),
              child: const SideDrawer(dWidth: 400)
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: MediaQuery.of(context).size.width < 700
                      ? const EdgeInsets.only(left: 5.0, right: 5.0, top: 15)
                      : const EdgeInsets.only(left: 30.0, right: 30.0, top: 15),
                  child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Visibility(
                            visible: isNotVisible(),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: (){
                                          Navigator.pushNamed(context, Routes.singleProduct);
                                        },
                                        child: const Icon(Icons.favorite)
                                    ),
                                    const SizedBox(width: 8),
                                    InkWell(
                                        onTap: ()async{
                                          await value.cartidmethod();
                                          final st=await value.alreadypaid(context);
                                          Navigator.pushNamed(context, Routes.cart);
                                        },
                                        child: const Icon(Icons.shopping_cart)
                                    ),
                                    const SizedBox(width: 8),
                                    Text("Total: USD ${value.mycarttotal}",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Visibility(
                            visible: true,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                                  child: Row(
                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: Container(
                                            child: Wrap(
                                              runSpacing: 10,
                                              spacing: 10,
                                              alignment: WrapAlignment.spaceBetween,
                                              runAlignment: WrapAlignment.spaceBetween,
                                              children: [
                                                PopupMenuTheme(
                                                  data: PopupMenuThemeData(
                                                    color: Colors.lightBlue[50],
                                                  ),
                                                  child: Container(
                                                    constraints: const BoxConstraints(maxWidth: 800, minWidth: 650),
                                                    color: Global.mainColor,
                                                    height: 50,
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              const Icon(Icons.menu, color: Colors.white),
                                                              const SizedBox(width: 8), // Spacing between icon and text
                                                              FutureBuilder<QuerySnapshot>(
                                                                future: value.db.collection("category").get(),
                                                                builder: (context, snapshot) {
                                                                  if (!snapshot.hasData) {
                                                                    return const Text("Loading");
                                                                  }
                                                                  if (snapshot.hasError) {
                                                                    return  Text("Error!!${snapshot.error}");
                                                                  }
                                                                  if (snapshot.connectionState==ConnectionState.waiting) {
                                                                    return  const Text("Please wait");
                                                                  }
                                                                  return PopupMenuButton<String>(
                                                                    onSelected: (selectedCategory) {
                                                                      // Perform action based on selected category
                                                                      setState(() {
                                                                        value.selected_category(selectedCategory);
                                                                        shoenum = selectedCategory;
                                                                      });
                                                                    },
                                                                    itemBuilder: (BuildContext context) {
                                                                      return snapshot.data!.docs.map((DocumentSnapshot document) {
                                                                        String categoryName = document['name'];
                                                                        return PopupMenuItem<String>(
                                                                          value: categoryName,
                                                                          child: Text(categoryName),
                                                                        );
                                                                      }).toList();
                                                                    },
                                                                    child: const Text(
                                                                      "BASKET CATEGORIES",
                                                                      style: TextStyle(color: Colors.white),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                          const Icon(
                                                            Icons.arrow_drop_down,
                                                            size: 30,
                                                            color: Colors.white,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  constraints: const BoxConstraints(maxWidth: 800, minWidth: 650), // Limit width
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligns children inside the row
                                                    children: [
                                                      // Search Input
                                                      Flexible(
                                                        flex: 3,
                                                        child: TextField(
                                                          controller: searchController,
                                                          onChanged: (txt) {
                                                            setState(() {
                                                              searchQuery = txt;
                                                            });
                                                          },
                                                          decoration: InputDecoration(
                                                            hintText: 'Search for anything',
                                                            hintStyle: TextStyle(
                                                              color: Colors.grey[500],
                                                              fontSize: 16,
                                                            ),
                                                            fillColor: Colors.white,
                                                            filled: true,
                                                            suffixIcon: Icon(Icons.search, color: Colors.blue), // Search Icon
                                                            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Padding inside TextField
                                                            border: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(30), // Rounded corners
                                                              borderSide: BorderSide.none, // No visible border
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(30),
                                                              borderSide: BorderSide(
                                                                  color: Colors.blue,
                                                                  width: 1
                                                              ),
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(30),
                                                              borderSide: BorderSide.none,
                                                            ),
                                                          ),
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Padding(
                                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.blue,
                                                    width: 1
                                                ),
                                                borderRadius: BorderRadius.circular(30)
                                            ),
                                            height: 30,
                                            width: 80,
                                            child: Center(child: Text("Default")),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.blue,
                                                    width: 1
                                                ),
                                                borderRadius: BorderRadius.circular(30)
                                            ),
                                            child: const Center(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Text("Sort by"),
                                                    Icon(Icons.arrow_drop_down),
                                                  ],
                                                )
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Visibility(
                                          visible: show,
                                          child: Container(
                                            height: 400,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 20.0,top: 20),
                                              child: SizedBox(height: 300,
                                                child:FutureBuilder<QuerySnapshot>(
                                                    future: value.db.collection("category").get(),
                                                    builder: (context, snapshot) {
                                                      if(!snapshot.hasData)
                                                      {
                                                        return Text("No data yet");

                                                      }
                                                      return ListView.builder(
                                                        itemCount: snapshot.data!.docs.length,
                                                        scrollDirection: Axis.vertical,
                                                        itemBuilder: (BuildContext context, int index) {
                                                          String categoryName = snapshot.data!.docs[index]['name'];
                                                          return  InkWell(
                                                            onTap: (){},
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.all(4.0),
                                                                  child: InkWell(
                                                                    onTap: (){
                                                                      setState(() {
                                                                        value.selected_category(categoryName);
                                                                        shoenum=categoryName;
                                                                      });
                                                                    },
                                                                    child: MenuType(
                                                                        isSelected: false,
                                                                        coffeeType: categoryName
                                                                    ),
                                                                  ),
                                                                ),
                                                                Divider(thickness: 1,color: Colors.grey[200],),

                                                              ],
                                                            ),
                                                          );

                                                        },
                                                      );
                                                    }
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                visible: false,
                                child: Expanded(
                                    child: SizedBox(
                                      height: 1200,
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: (){},
                                            child: Container(
                                              height: 50,
                                              color: Global.mainColor,
                                              child: const Padding(
                                                padding: EdgeInsets.only(left: 18.0, right: 18),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons.menu, color: Colors.white,),
                                                          Text(
                                                            "ALL CATEGORIES",
                                                            style: TextStyle(
                                                                color: Colors.white
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.arrow_drop_down, size: 30, color: Colors.white,),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            color: Colors.white,
                                            height: 700,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 20.0, top: 20, right: 20),
                                              child: FutureBuilder<QuerySnapshot>(
                                                future: Dbfields.db.collection("category").get(),
                                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                                                  if (!snapshot.hasData)
                                                  {
                                                    return Text("No data");
                                                  }
                                                  if (snapshot.hasError)
                                                  {
                                                    return Text("Error");
                                                  }

                                                  if (snapshot.hasError)
                                                  {
                                                    return Text("Error");
                                                  }

                                                  return ListView.builder(
                                                    scrollDirection: Axis.vertical,
                                                    itemCount: snapshot.data!.docs.length,
                                                    itemBuilder: (BuildContext context, int index) {
                                                      active.add(false);
                                                      String cate=snapshot.data!.docs[index]['name'];
                                                      return Container(child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          InkWell(
                                                            onTap: (){
                                                              setState(() {
                                                                value.selected_category("");
                                                                searchQuery=cate;
                                                              });
                                                              // setState(() {
                                                              //   shoenum=Ecom().capitalizeSentence(cate);
                                                              //   querysnapshot=Dbfields.db.collection("items").where(ItemReg.category,isEqualTo: cate).snapshots();
                                                              //   if(active[index])
                                                              //   {
                                                              //     active.add(false);
                                                              //   } else{
                                                              //     active[index]=true;
                                                              //   }
                                                              //
                                                              // });
                                                            },
                                                            child: MenuType(
                                                                isSelected: active[index],
                                                                coffeeType: cate
                                                            ),
                                                          ),
                                                          Divider(thickness: 1,color: Colors.grey[200],),
                                                          const SizedBox(height: 10),
                                                        ],
                                                      ),
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                        ],
                                      ),
                                    )
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                  flex: 3,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                          height: 1200,
                                          child: FutureBuilder<QuerySnapshot>(
                                            future: Dbfields.db.collection("items").orderBy(ItemReg.category).get(),
                                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                              if(snapshot.connectionState==ConnectionState.waiting){
                                                return const Text("Please Wait...");
                                              }
                                              if(!snapshot.hasData){
                                                return const Text("Loading...");
                                              }
                                               if(snapshot.connectionState==ConnectionState.waiting)
                                              {
                                                const CircularProgressIndicator();
                                              }
                                               if(snapshot.hasError)
                                              {
                                                return const Text("Error Loading Data");
                                              }
                                              urls.clear();
                                              myimage.clear();
                                              for(int i=0; i<snapshot.data!.docs.length;i++){
                                                String url_txt = snapshot.data!.docs[i]['itemurl'];

                                                myimage.add(
                                                    CachedNetworkImage(
                                                      errorListener:(rr){
                                                        //print("${name_txt} image are not uploaded yet");
                                                      } ,
                                                      imageUrl: url_txt,
                                                      height: 200,
                                                      width: 300,
                                                      fit: BoxFit.fill,
                                                      placeholder: (context, url) => const Center(
                                                        child: SizedBox(
                                                          height: 50,
                                                          width: 50,
                                                          child: CircularProgressIndicator(),
                                                        ),
                                                      ),
                                                      errorWidget: (context, url, error) =>const Icon(Icons.error,color: Colors.red,),

                                                    )
                                                );


                                              }
                                              var filteredDocs = snapshot.data!.docs.where((doc) {
                                                var data = doc.data() as Map<String, dynamic>;
                                                String item = data['item']?.toString().toLowerCase() ?? '';
                                                String category = data['category']?.toString().toLowerCase() ?? '';
                                                String price = data['sellingprice']?.toString().toLowerCase() ?? '';
                                                if(value.selectedcategory.isNotEmpty){
                                                  return  category.contains(searchQuery.toLowerCase());

                                                }
                                                else
                                                {
                                                  return item.contains(searchQuery.toLowerCase()) || category.contains(searchQuery.toLowerCase() )||price.contains(searchQuery.toLowerCase());

                                                }

                                              }).toList();
                                              // for(int i=0;i<snapshot.data!.docs.length;i++){
                                              //   //print(i);
                                              //   String url= snapshot.data!.docs[i][ItemReg.itemurl];
                                              //   urls.add(url);
                                              //
                                              //   //print(url);
                                              //
                                              //
                                              // }
                                              return GridView.builder(
                                                physics: BouncingScrollPhysics(),
                                                itemCount: filteredDocs.length,
                                                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                                  mainAxisSpacing: 0.6,
                                                  childAspectRatio: 0.7,
                                                  crossAxisCount: crossAxisCount.ceil(),
                                                ), itemBuilder: (BuildContext context, int index) {
                                                final fetchedData = filteredDocs[index];
                                                String itemname=fetchedData['item'];
                                                String code=fetchedData['code'];
                                                String url=fetchedData['itemurl'];
                                                String sellingprice=fetchedData[ItemReg.sellingprice];

                                                return FittedBox(
                                                  child: Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: ()async{
                                                          // print(widget.name);
                                                          await value.set_selecteditem(fetchedData[ItemReg.code]);
                                                          await value.get_current_item();
                                                          Navigator.pushNamed(context, Routes.singleProduct);
                                                        },
                                                        child: Container(
                                                          // height: 300,
                                                          width: 220,
                                                          child: FeaturedProduct(
                                                            frompage: "shop",
                                                            featuredImage:url,
                                                            featuredName: itemname,
                                                            featuredPrice: sellingprice,
                                                            image:myimage[index],
                                                            progress: false,
                                                            consWidth: itemWidth,
                                                            featuredcode: code,
                                                          ),
                                                        ),
                                                      )
                                                      // items[index]

                                                    ],
                                                  ),
                                                );
                                              },);
                                              // Wrap(
                                              // runSpacing: 5,
                                              // spacing: 5,
                                              // children: items
                                              // );

                                            },
                                          )

                                        //featuredGridview(shoenum: shoenum, widgth: 300, height: 200, name: 16, price: 16, favHeight: 30, favWidth: 100, favSize: 25, cartHeight: 30, cartWidth: 100, cartSize: 25, querySnapshot: querysnapshot,),
                                      ),
                                    ],
                                  )
                              )
                            ],
                          )
                        ],
                      )
                  ),
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible: isVisible(),
                  child:  DesktopFooter(value: value,),
                ),
                Visibility(
                  visible: isNotVisible(),
                  child:  TabletFooter(value: value,),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
