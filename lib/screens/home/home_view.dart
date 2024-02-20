import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                  itemCount: 1 ,
                  itemBuilder: (context, index){
                    return Container(
                      width: 100.w,
                      height: 25.h,
                      color: Colors.red,
                      child: Card(
                        elevation: 5.sp,
                        // shadowColor: Colors.grey.shade600,
                        color: Colors.grey.shade900,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side:  BorderSide(width: 1, color: Colors.grey.shade800)),
                        child:  Stack(
                          children: [
                            Center(
                              child: Image(
                                height: 17.h,
                               width: 100.w,
                               fit:BoxFit.cover ,
                                  image: NetworkImage('https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80')),
                            ),
                            Positioned(
                                left: 3.w,
                                top: 1.h,
                                child: Text('10000 PKR/day', style: TextStyle(color: Colors.white),)),

                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
