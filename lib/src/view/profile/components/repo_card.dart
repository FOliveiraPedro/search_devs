import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:search_devs/src/view/profile/components/web_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/domain/entity/repo.dart';
import 'user_data.dart';

class RepoCard extends StatelessWidget {
  final Repo repo;

  const RepoCard({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WebView(url: repo.htmlUrl)));
            },
            child: Text(
              repo.name,
              style:
                  GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Visibility(
            visible: repo.description == "" ? false : true,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Text(
                repo.description,
                style: GoogleFonts.inter(
                    color: const Color(
                      0xFF4A5568,
                    ),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Row(
            children: [
              UserData(
                icon: Icons.star_border_outlined,
                data: repo.stargazersCount.toString(),
              ),
              const SizedBox(
                width: 16,
              ),
              UserData(
                icon: Icons.favorite_border_outlined,
                data:
                    "Atualizado em ${repo.updatedAt.day}/${repo.updatedAt.month}/${repo.updatedAt.year}",
              ),
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}
