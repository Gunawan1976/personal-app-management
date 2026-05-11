
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/enum.dart';
import '../../../../shared/widget/custom_text_widget.dart';
import '../../../detail_produk/presentation/pages/single_produk_page.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextView(text: "Home Pages",fontWeight: FontWeight.w600,),
        centerTitle: true,

      ),
      body:  Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollEndNotification) {
                if (notification.metrics.pixels == 0 &&
                    notification.metrics.axis == Axis.vertical) {
                  // Disable aksi ketika mencapai scroll paling atas
                  return true; // Menonaktifkan notifikasi lebih lanjut
                }
                if (notification.metrics.pixels ==
                    notification.metrics.maxScrollExtent &&
                    notification.metrics.axis == Axis.vertical) {
                  // if(state.page == state.produk!.total){
                  //
                  // }else{
                  //   context.read<HomeBloc>().add(GetProduk());
                  // }
                }
              }
              return true;
            },
            child:  ListView.builder(
              itemCount:0 + 1,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if (index == 0) {

                }

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SingleProdukPage(id:  0,), // Kirim data user
                        ),
                      );
                    },
                    contentPadding: EdgeInsetsGeometry.all(8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    tileColor: Colors.grey.shade200,
                    leading: Container(
                      width: 80.w,
                      height: 80.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage( ""),
                            fit: BoxFit.contain,
                          )
                      ),
                    ),
                    title: TextView(text:"",fontWeight: FontWeight.w600),
                    subtitle: SizedBox(height:50.h,child: TextView(text:  "",maxLines: 3,overflow: TextOverflow.ellipsis,)),
                    trailing: TextView(text:"\$${0.0}"),
                  ),
                );
              },),
          )
      )
    );
  }
}

