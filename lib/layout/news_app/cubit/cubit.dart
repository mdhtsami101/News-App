
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/modules/news_app/business/business_screen.dart';
import 'package:news_app/modules/news_app/science/science_screen.dart';
import 'package:news_app/modules/news_app/sports/sports_screen.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit(): super(NewsInitialState());

  static NewsCubit get(context)=>BlocProvider.of(context);

  int currentIndex=0;

  List<BottomNavigationBarItem>bottomItems=[
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),

  ];

  List<Widget>screens=[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),

  ];

  void changeBottomNavBar(int index){
    currentIndex=index;
    if(index==1){
      getSports();
    }
    if(index==2){
      getScience();
    }

    emit(NewsBottomNavState());
  }

  List<dynamic>business=[];
  // List<bool>businessSelectedItem=[];
  int businessSelectedItem = 2 ;
  bool isDesktop = false;

  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'us',
          'category':'business',
          'apiKey':'8d4a15c69fa14eeabea03b0b046a578b',
        }
    ).then((value) {
      business=value.data['articles'];
      // business.forEach((element) {
      //   businessSelectedItem.add(false);
      // });
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  void selectBusinessItem(index){
    businessSelectedItem = index;
    // for(int i=0 ; i<businessSelectedItem.length ; i++){
    //   if(index == i)
    //     businessSelectedItem[i]=true;
    //   else
    //     businessSelectedItem[i]=false;
    // };

    emit(NewsBusinessSelectItemState());
  }

  void setDesktop(bool value){
    isDesktop= value;
    emit(NewsSetDesktopState());
  }

  List<dynamic>sports=[];

  void getSports(){
    emit(NewsGetBusinessLoadingState());
    if(sports.length==0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'us',
            'category':'sports',
            'apiKey':'8d4a15c69fa14eeabea03b0b046a578b',
          }
      ).then((value) {
        sports=value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }else{
      emit(NewsGetSportsSuccessState());
    }


  }

  List<dynamic>science=[];

  void getScience(){
    emit(NewsGetBusinessLoadingState());
    if(science.length==0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'us',
            'category':'science',
            'apiKey':'8d4a15c69fa14eeabea03b0b046a578b',
          }
      ).then((value) {
        science=value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }else{
      emit(NewsGetScienceSuccessState());
    }

  }

  List<dynamic>search=[];

  void getSearch(value){

    emit(NewsGetSearchLoadingState());

    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q':'$value',
          'apiKey':'8d4a15c69fa14eeabea03b0b046a578b',
        }
    ).then((value) {
      search=value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });

  }

}