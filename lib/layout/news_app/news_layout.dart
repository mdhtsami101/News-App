
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/modules/news_app/search/search_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';

class NewsLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {} ,
      builder: (context, state) {
        var cubit=NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title:Text(
              'News App',
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context, SearchScreen());
                  },
                  icon:Icon(
                    Icons.search
                  )
              ),
              IconButton(
                  onPressed: (){
                    AppCubit.get(context).changeAppMod();
                  },
                  icon:Icon(
                    Icons.brightness_4_outlined
                  )
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          // floatingActionButton: FloatingActionButton(
          //   onPressed: (){
          //
          //   },
          //   child: Icon(
          //     Icons.add,
          //   ),
          // ),
          bottomNavigationBar:BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomItems,
          ),
        );
      } ,

    );
  }
}
