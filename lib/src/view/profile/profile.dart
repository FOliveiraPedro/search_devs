//Packages
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

//Project
import '../../core/domain/entity/repo.dart';
import '../../core/domain/entity/user.dart';
import 'components/repo_card.dart';
import 'components/user_data.dart';
import 'components/web_view.dart';
import 'controller/profile_controller.dart';
import 'states/profile_states.dart';

class Profile extends StatefulWidget {
  late User user;

  Profile({required this.user, super.key});

  static void navigate(User user) {
    Modular.to.pushNamed(
      '/profile',
      arguments: {'user': user},
    );
  }

  Profile.fromArgs(dynamic arguments) {
    user = arguments.data['user'];
  }

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends ModularState<Profile, ProfileController> {
  static const _pageSize = 10;

  final PagingController<int, Repo> _pagingController =
  PagingController(firstPageKey: 0);

  @override
  void initState() {
    controller.add(widget.user.login);
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await controller.getNewRepos(widget.user.login, pageKey);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        print(nextPageKey);
        _pagingController.appendPage(newItems, nextPageKey as int?);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 315,
              padding: EdgeInsets.symmetric(horizontal: 8),
              color: Color(
                0xFFEADDFF,
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(widget.user.avatar),
                        radius: 30,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      SizedBox(
                        height: 70,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.user.name,
                              style: GoogleFonts.inter(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.user.login,
                              style: GoogleFonts.inter(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      UserData(
                        icon: Icons.person_outlined,
                        data: "${widget.user.followers} seguidores",
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      UserData(
                        icon: Icons.favorite_border_outlined,
                        data: "${widget.user.following} seguindo",
                      ),
                    ],
                  ),
                  Visibility(
                    visible: widget.user.bio == "" ? false : true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        widget.user.bio,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: widget.user.company == "" ? false : true,
                        child: UserData(
                          icon: Icons.business,
                          data: "${widget.user.company}",
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Visibility(
                        visible: widget.user.location == "" ? false : true,
                        child: UserData(
                          icon: Icons.location_on_outlined,
                          data: "${widget.user.location}",
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Visibility(
                        visible: widget.user.email == "" ? false : true,
                        child: UserData(
                          icon: Icons.email_outlined,
                          data: "${widget.user.email}",
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: widget.user.blog == "" ? false : true,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => WebView(
                                      url: "http://" + widget.user.blog)));
                            },
                            child: UserData(
                              icon: Icons.link,
                              data: "${widget.user.blog}",
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Visibility(
                          visible:
                              widget.user.twitterUsername == "" ? false : true,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => WebView(
                                      url: "https://x.com/" +
                                          widget.user.twitterUsername)));
                            },
                            child: UserData(
                              icon: FontAwesomeIcons.twitter,
                              data: "${widget.user.twitterUsername}",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<ProfileState>(
                  stream: controller.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var state = controller.state;
                      if (state is ErrorState) {
                        // return _buildError(state.error);
                      }
                      if (state is StartState) {
                        return Container();
                      } else if (state is LoadingState) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is SuccessState) {
                        return PagedListView<int, Repo>(
                          pagingController: _pagingController,
                          builderDelegate: PagedChildBuilderDelegate<Repo>(
                            itemBuilder: (context, item, index) => RepoCard(
                              repo: item,
                            )
                          ),
                        );
                      }
                      return Container();
                    } else {
                      return Container();
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
