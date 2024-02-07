import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SellerHomeView extends StatelessWidget {
  const SellerHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 5,
              
              automaticallyImplyLeading: false,
              title: Container(
                width: 100.w,
                color: Colors.yellow,
                alignment: Alignment.center,
                child: Text('Hi, Seller Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),),
              ),
              pinned: true,
              centerTitle: true,
              expandedHeight: 30.h,
              backgroundColor: Colors.yellow,
              flexibleSpace:  FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey
                  ),
                  child: IconButton(icon: const Icon(Icons.add), onPressed: (){},),
                ),
                centerTitle: true,
                title: const Text('Flexible Bar', style: TextStyle(color: Colors.black),),
              ),
            ),
            // SliverList.builder(itemBuilder: (BuildContext context, int index){
            //   return con
            // })
          ],
        ),
      ),
    );
  }
}