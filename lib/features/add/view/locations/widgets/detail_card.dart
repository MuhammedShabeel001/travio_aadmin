import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  const DetailCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
              color: Colors.purple[100],
                child: SizedBox(
                  height: 380,
                  child: Column(
                    children: [
                      Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: double.infinity ,
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                              child:Image.asset('assets/image/ios-18-neuerungen-teaser-neu_6295364.jpg',fit: BoxFit.fitWidth,),
                            ),
                          ),
                          // child: Image.asset('assets/image/ios-18-neuerungen-teaser-neu_6295364.jpg',fit: BoxFit.fitWidth,)
                          ),
                      Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.all(12 ),
                            // color: Color.fromARGB(255, 101, 59, 255),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    'Title is too long to fit this space so the text will',
                                    maxLines: 1,
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                ),
                                SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of",
                                      maxLines: 5,
                                      style: TextStyle(
                                          fontSize: 18,
                                          overflow: TextOverflow.ellipsis),
                                    )),
                                    SizedBox(height: 20,),
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        // color: Colors.amber,
                                        child: Text(
                                          'Activities',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      // SizedBox()
                                      Row(
                                        children: [
                                          Container(
                                            // color: Colors.black,
                                            child: IconButton(
                                                onPressed: () {},
                                                icon: Icon(Icons.delete)),
                                          ),
                                          Container(
                                            // color: Colors.blue,
                                            child: IconButton(
                                                onPressed: () {},
                                                icon: Icon(Icons.edit)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
                ));
  }
}