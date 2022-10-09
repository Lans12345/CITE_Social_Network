import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:monetization_system/presentation/pages/searched_profile_page.dart';
import 'package:monetization_system/presentation/widgets/text_widget.dart';
import 'package:get_storage/get_storage.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final box = GetStorage();
  late String query = '';
  late String result = '';
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FloatingSearchBar(
          hint: 'Search user',
          openAxisAlignment: 0.0,
          axisAlignment: 0.0,
          scrollPadding: const EdgeInsets.only(top: 16, bottom: 20),
          elevation: 4.0,
          physics: const BouncingScrollPhysics(),
          onQueryChanged: (_query) {
            query = _query;
          },
          transitionCurve: Curves.easeInOut,
          transitionDuration: const Duration(milliseconds: 500),
          transition: CircularFloatingSearchBarTransition(),
          debounceDelay: const Duration(milliseconds: 500),
          actions: [
            FloatingSearchBarAction(
              showIfOpened: true,
              child: CircularButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    result = query;
                  });
                },
              ),
            ),
          ],
          builder: (context, transition) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Material(
                color: Colors.black,
                child: Container(
                  height: 200.0,
                  color: Colors.white,
                  child: SizedBox(
                    height: 200.0,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Users')
                            .where('name', isEqualTo: result)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            print('error');
                            return const Center(child: Text('Error'));
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            print('waiting');
                            return const Padding(
                              padding: EdgeInsets.only(top: 50),
                              child: Center(
                                  child: CircularProgressIndicator(
                                color: Colors.black,
                              )),
                            );
                          }

                          final data = snapshot.requireData;
                          return ListView.separated(
                              separatorBuilder: ((context, index) {
                                return const Divider();
                              }),
                              itemCount: snapshot.data?.size ?? 0,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 20, 10, 0),
                                  child: ListTile(
                                      onTap: () {
                                        box.write('searched_email',
                                            data.docs[index]['email']);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SearchedProfilePage()));
                                      },
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        maxRadius: 30,
                                        minRadius: 30,
                                        backgroundImage: NetworkImage(
                                            data.docs[index]['profilePicture']),
                                      ),
                                      title: TextBold(
                                          text: data.docs[index]['name'],
                                          fontSize: 18,
                                          color: Colors.grey)),
                                );
                              });
                        }),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
