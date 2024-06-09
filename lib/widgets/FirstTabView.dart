import 'package:flutter/material.dart';
import 'package:ebook_ui/Colors/app_colors.dart' as AppColors;

class FirstTab extends StatelessWidget {
  final int? listLength;
  final String? ImageURL;
  var Rating;
  final String Title;
  final String Subtitle;


   FirstTab({super.key,required this.listLength,required this.Rating, required this.ImageURL, required this.Title, required this.Subtitle});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 120,
      margin: const EdgeInsets.only(
          left: 20, right: 20, top: 10, bottom: 10),
      decoration: BoxDecoration(),
      child: Container(
        height: 120,
        width: 90,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 2,
                  offset: Offset(0, 0),
                  color: Colors.grey.withOpacity(0.2))
            ]),
        child: Container(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                height: 120,
                width: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            ImageURL!))),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        Rating.toString(),
                        style: TextStyle(
                            color: AppColors.menue2Color),
                      ),
                    ],
                  ),
                  Text(
                    Title,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Avenir",
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    Subtitle,
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Avenir",
                        color: AppColors.subTitleColor),
                  ),
                  SizedBox(height:10 ,),
                  Container(
                    height: 20,
                    width: 60,
                    alignment: Alignment.center,
                    child: Text(
                      "Love",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Avenir",
                          color: Colors.white),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5)
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
