import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/app_states.dart';
import 'package:news_app/bloc/get_source_news_bloc.dart';
import 'package:news_app/bloc/get_sources_bloc.dart';
import 'package:news_app/model/source.dart';
import 'package:news_app/screens/source_details_screen.dart';

class TopChannels extends StatefulWidget {
  @override
  _TopChannelsState createState() => _TopChannelsState();
}

class _TopChannelsState extends State<TopChannels> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GetSourcesCubit>(context, listen: false).getSources();
  }

  @override
  Widget build(BuildContext context) {
      return BlocBuilder<GetSourcesCubit, AppStates>(
        builder: (context, state) {
          final sourceCubit = GetSourcesCubit().get(context);
          final sourceNewsCubit = GetSourceNewsCubit.get(context);
          return _buildTopChannels(sourceCubit.sources , sourceNewsCubit);
          // ConditionalBuilder(
          // condition: sourceCubit.sources.isNotEmpty,
          // fallback: (context) => Center(
          //       child: CircularProgressIndicator(),
          //     ),
          // builder: (context) => _buildTopChannels(sourceCubit.sources));
        },
      );
  }

  Widget _buildTopChannels(List<SourceModel> sources ,GetSourceNewsCubit sourceNewsCubit ) {
    if (sources.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Text('No Sources'),
          ],
        ),
      );
    } else {
      return  Container(
          height: 115,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: sources.length,
              itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.only(top: 10),
                    width: 80,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                                value: sourceNewsCubit,
                            child: SourceDetails(source: sources[index],),)));
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        // SourceDetails(source: sources[index])));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Hero(
                              tag: sources[index].id,
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 5,
                                          spreadRadius: 1,
                                          offset: Offset(1.0, 1.0)),
                                    ],
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          'assets/logos/${sources[index].id}.png'),
                                    )),
                              )),
                          SizedBox(
                            height: 12,
                          ),
                          Text(sources[index].name,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                            style: TextStyle(
                              height: 1.4,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 10
                            ),
                          ),
                          SizedBox(height: 3,),
                          Text(sources[index].category,
                          maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 9
                            ),


                          )
                        ],
                      ),
                    ),
                  ),
          ),
      );
    }
  }
}
