import 'package:flutter/material.dart';
import 'package:travio_admin_/core/common/widgets/navigation_bar.dart';

class UserTile extends StatelessWidget {
  final String image;
  final String name;
  final String email;
  final String reviews;

  const UserTile({
    super.key, required this.image, required this.name, required this.email, required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.orange.shade100,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10 ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 60 ,
              width: 60,
              child: Image.asset(
                image,
                // height: 60,
                // width: 60, 
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(name,style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(email,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
              Text(reviews,style: const TextStyle(fontSize: 16)),
            ],
            
          ),
          trailing: IconButton(onPressed: (){}, icon: const SvgIcon('assets/icons/more.svg',)),
        ),
      ),
    );
  }
}
