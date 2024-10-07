import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../widgets/route.dart';

class ResponsiveGridView extends StatelessWidget {
  final filteredDocs;
  final double itemWidth;
  final value;

  ResponsiveGridView({
    required this.filteredDocs,
    required this.itemWidth,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the crossAxisCount based on screen width
    final double screenWidth = MediaQuery.of(context).size.width;
    final int crossAxisCount = (screenWidth / itemWidth).floor(); // Adjust itemWidth as needed

    return GridView.builder(

      shrinkWrap: true,  // Add this line to avoid size issues
      itemCount: filteredDocs.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 8.0, // Adjust spacing as needed
        crossAxisSpacing: 8.0, // Adjust spacing as needed
        childAspectRatio: 0.7,
      ),
      itemBuilder: (BuildContext context, int index) {
        final fetchedData = filteredDocs[index];
        String itemname = fetchedData['item'];
        String code = fetchedData['code'];
        String url = fetchedData['itemurl'];
        String sellingprice = fetchedData['sellingprice'];

        return InkWell(
          onTap: () async {
            // Handle item tap
            await value.set_selecteditem(fetchedData['code']);
            await value.get_current_item();
            Navigator.pushNamed(context, Routes.singleProduct);
          },
          child:
          Container(
            padding: EdgeInsets.all(8.0), // Adjust padding as needed
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: url,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  itemname,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'USD $sellingprice',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
