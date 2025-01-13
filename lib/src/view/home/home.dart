//Package
import 'package:field_suggestion/field_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:search_devs/src/view/home/states/home_states.dart';

//Project
import 'components/user_card.dart';
import '../profile/profile.dart';
import 'controller/home_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends ModularState<Home, HomeController> {
  final usernameController = TextEditingController();

  List<String> suggestionList = [];

  @override
  void initState() {
    controller.getSuggestionList().then((value) {
      setState(() {
        suggestionList = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Search ",
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w500,
                          fontSize: 50,
                          color: Color(0xFF0069CA)),
                    ),
                    Text(
                      "d_evs",
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w500,
                          fontSize: 50,
                          color: Color(0xFF8C19D2)),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Column(
                  children: [
                    SizedBox(
                      height: 56,
                      child: TextFormField(
                        controller: usernameController,
                        onEditingComplete: () {
                          controller.add(usernameController.text);
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.primary),
                          labelText: "Search",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          prefixIcon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<HomeState>(
                  stream: controller.stream,
                  builder: (context, snapshot) {
                    var state = controller.state;
                    print(state);

                    if (state is ErrorState) {
                      return Text(state.message);
                    }
                    if (state is StartState) {
                      if (suggestionList != []) {
                        return Container(
                          height: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  "Ultimos usuarios pesquisados",
                                  style: GoogleFonts.nunito(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: suggestionList.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        child: Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 6),
                                          padding: EdgeInsets.symmetric(horizontal: 8),
                                          child: Text(
                                            suggestionList[index],
                                            style: GoogleFonts.nunito(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        onTap: (){
                                          controller.add(suggestionList[index]);
                                        },
                                      );
                                    }),
                              ),
                            ],
                          ),
                        );
                      }
                      return Container();
                    } else if (state is LoadingState) {
                      return CircularProgressIndicator();
                    } else if (state is SuccessState) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: GestureDetector(
                            onTap: () {
                              Profile.navigate(state.user);
                            },
                            child: UserCard(user: state.user)),
                      );
                    }
                    return Container();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
