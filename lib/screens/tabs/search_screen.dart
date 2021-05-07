import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/app_states.dart';
import 'package:news_app/bloc/search_bloc.dart';
import 'package:news_app/style/theme.dart' as Style;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _serchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SearchCubit()..search(_serchController.text),
        child: BlocBuilder<SearchCubit, AppStates>(
          builder: (context, state) {
            final searchCubit = SearchCubit.get(context);
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    style: TextStyle(fontSize: 14.0, color: Colors.black),
                    controller: _serchController,
                    onChanged: (changed) {
                      _serchController.text= changed;
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: true,
                      fillColor: Colors.grey[100],
                      suffixIcon: _serchController.text.length > 0
                          ? IconButton(
                              icon: Icon(
                                EvaIcons.backspaceOutline,
                                color: Colors.grey[500],
                                size: 16.0,
                              ),
                              onPressed: () {
                                  // FocusScope.of(context)
                                  //     .requestFocus(FocusNode());
                                  _serchController.clear();
                                  searchCubit.search(_serchController.text);

                              })
                          : Icon(
                              EvaIcons.searchOutline,
                              color: Colors.grey[500],
                              size: 16.0,
                            ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: new BorderSide(
                              color: Colors.grey[100].withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(30.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(
                              color: Colors.grey[100].withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(30.0)),
                      contentPadding: EdgeInsets.only(left: 15.0, right: 10.0),
                      labelText: "Search...",
                      hintStyle: TextStyle(
                          fontSize: 14.0,
                          color: Style.Colors.grey,
                          fontWeight: FontWeight.w500),
                      labelStyle: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    autocorrect: false,
                    autovalidate: true,
                  ),
                ),
                // Expanded(child: )
              ],
            );
          },
        ));
  }
}
