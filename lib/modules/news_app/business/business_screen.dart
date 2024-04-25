
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BusinessScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {

      },
      builder: (context, state){
        var list = NewsCubit.get(context).business;
        return ScreenTypeLayout(
          mobile: Builder(
            builder: (context) {
              NewsCubit.get(context).setDesktop(false);
              return articleBuilder(list, context);
            },
          ) ,
          desktop:Builder(
            builder: (context) {
              NewsCubit.get(context).setDesktop(true);
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: 500.0,
                      child: articleBuilder(list, context),),
                  ),
                  if(list.length>0)
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        color: Colors.grey[200],
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Text(
                              '${list[NewsCubit.get(context).businessSelectedItem]['description']}'
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          breakpoints: ScreenBreakpoints(
            desktop: 850.0,
            tablet: 300.0,
            watch: 100.0,
          ),
        );
      },

    );
  }
}
