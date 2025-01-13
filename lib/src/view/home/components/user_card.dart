//Packages
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//Project
import '../../../core/domain/entity/user.dart';

class UserCard extends StatelessWidget {
  final User user;
  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child:  Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 8,),
          CircleAvatar(
            backgroundImage: NetworkImage(user.avatar),
            radius: 30,
          ),
          const SizedBox(width: 8,),
          SizedBox(
            height: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(user.name, style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold),),
                Text(user.login, style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w500),),
              ],
            ),
          )
        ],
      ),
    );
  }
}