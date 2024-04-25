

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/modules/news_app/web_view/web_view_screen.dart';




Widget defaultButton({
   double width = double.infinity ,
   double radius = 0.0 ,
   Color background=Colors.blue ,
   bool isUpperCase = true,
  required Function  ,
  required String text ,
}) =>
    Container(
      width: width,
      height: 40.0,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        onPressed:   Function ,
        child: Text(
         isUpperCase? text.toUpperCase():text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );


Widget defaultTextButton({
  required Function ,
  required String text ,
})=>TextButton(
onPressed:Function,
child: Text(text.toUpperCase(),),
);




Widget defaultFormField ({
  required TextEditingController controller,
  required TextInputType type,
  onSubmit,
  onChange,
  onTap,
  required  validat,
  bool isPassword = false,
  required String lable ,
  required IconData prefix,
  IconData? suffix ,
  suffixPressed,
})=>
TextFormField(
  controller: controller,
  keyboardType: type ,
  onFieldSubmitted:onSubmit ,
  onChanged: onChange,
  validator: validat,
  onTap: onTap,
  obscureText: isPassword,
  decoration: InputDecoration(
    labelText:lable, //hintText: 'Email Address'
    border: OutlineInputBorder(),
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: suffix != null ? IconButton(
      onPressed:suffixPressed ,
      icon: Icon(
          suffix,
      ),
    ) : null,
  ),
);




Widget buildArticlesItem(article,context,index)=>Container(
  color: NewsCubit.get(context).businessSelectedItem == index && NewsCubit.get(context).isDesktop?Colors.grey[200]:null,
  child: InkWell(
    onTap: (){
      navigateTo(context, WebViewScreen(article['url']));
    },
    child:   Padding(

      padding: const EdgeInsets.all(20.0),

      child: Row(

        children: [

          Container(

            width: 120.0,

            height: 120.0,

            decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(10.0,),

                image:DecorationImage(

                  image: NetworkImage('${article['urlToImage']}'),

                  fit:BoxFit.cover,

                )

            ),

          ),

          SizedBox(

            width: 20.0,

          ),

          Expanded(

            child: Container(

              height: 120.0,

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                mainAxisAlignment: MainAxisAlignment.start,

                children: [

                  Expanded(

                    child: Text(

                      '${article['title']}',

                      style:Theme.of(context).textTheme.bodyText1,

                      maxLines:3,

                      overflow: TextOverflow.ellipsis,

                    ),

                  ),

                  Text(

                    '${article['publishedAt']}',

                    style: TextStyle(

                        color: Colors.grey

                    ),

                  ),

                ],

              ),

            ),

          ),

        ],

      ),

    ),
  ),
);


Widget myDivider()=>Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget articleBuilder(list,context, {isSearch=false})=>ConditionalBuilder(
  condition: list.length>0 ,
  builder:(context) => ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context , index)=>buildArticlesItem(list[index],context,index) ,
      separatorBuilder: (context , index)=>myDivider(),
      itemCount: list.length
  ) ,
  fallback:(context) => isSearch?Container() :Center(child: CircularProgressIndicator()) ,

);

void navigateTo(context , widget)=> Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context)=>widget,
  ),
);

void navigateAndFinish (context , widget)=> Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context)=>widget,
  ),
  (Route<dynamic>route) => false,
);

void showToast({
  required String text,
  required ToastStates state,
})=> Fluttertoast.showToast(

    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates {SUCCESS , ERROR , WARNING}

Color chooseToastColor( ToastStates state){
  Color color ;
  switch(state){
    case ToastStates.SUCCESS:
      color= Colors.green;
      break;
    case ToastStates.ERROR:
      color= Colors.red;
      break;
    case ToastStates.WARNING:
      color= Colors.amber;
      break;
  }

  return color;

}
