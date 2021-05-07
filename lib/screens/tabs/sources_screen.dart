import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/app_states.dart';
import 'package:news_app/bloc/get_source_news_bloc.dart';
import 'package:news_app/bloc/get_sources_bloc.dart';
import 'package:news_app/model/source.dart';

import '../source_details_screen.dart';

class SourcesScreen extends StatefulWidget {
  @override
  _SourcesScreenState createState() => _SourcesScreenState();
}

class _SourcesScreenState extends State<SourcesScreen> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetSourcesCubit()..getSources()),
        BlocProvider(create: (context) => GetSourceNewsCubit()),
      ],
      child: BlocBuilder<GetSourcesCubit, AppStates>(
        builder: (context, state) {
          final sourceCubit = GetSourcesCubit().get(context);
          final sourceNewsCubit = GetSourceNewsCubit.get(context);
          return _buildSources(sourceCubit.sources, sourceNewsCubit);
        },
      ),
    );
  }

  Widget _buildSources(
    List<SourceModel> sources,
    GetSourceNewsCubit sourceNewsCubit,
  ) {
    if (sources.length == 0) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 0.86),
      itemCount: sources.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                            value: sourceNewsCubit,
                            child: SourceDetails(
                              source: sources[index],
                            ),
                          )));
            },
            child: Container(
              width: 100.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[100],
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                    offset: Offset(
                      1.0,
                      1.0,
                    ),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: sources[index].id,
                    child: Container(
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/logos/${sources[index].id}.png"),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 15.0, bottom: 15.0),
                    child: Text(
                      sources[index].name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
