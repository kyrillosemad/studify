import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/view%20model/data/data_bloc.dart';
import 'package:studify/view/modules/class%20room/widgets/data_page_appbar.dart';
import 'package:studify/view/modules/class%20room/widgets/data_part.dart';
import 'package:studify/view/shared_widgets/search_field.dart';

class DataForDoctor extends StatelessWidget {
  const DataForDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DataBloc(),
        child: Builder(
          builder: (context) {
            var controller = context.read<DataBloc>();
            controller.add(GetData(controller.classId, ''));
            return Scaffold(
              appBar:
                  DataPageAppbar(type: "doctor", classId: controller.classId),
              body: Center(
                child: Container(
                  margin: EdgeInsets.only(top: 10.sp),
                  width: 100.w,
                  height: 100.h,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 2.h),
                        child: SearchField(
                          hint: "Search",
                          onChanged: (value) {
                            controller.add(
                                GetData(controller.classId, value.toString()));
                          },
                          type: TextInputType.text,
                        ),
                      ),
                      Expanded(
                        child: BlocBuilder<DataBloc, DataState>(
                          builder: (context, state) {
                            if (state is DataLoading) {
                              return  Center(
                                  child:  Lottie.asset(
              'assets/Animation - 1740512569959.json',
              height: 20.h,
              fit: BoxFit.contain,
            ));
                            }

                            if (state is DataError) {
                              return Center(
                                child: Text(
                                  'Error: ${state.msg}',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: MyColors().mainColors),
                                ),
                              );
                            }

                            if (state is DataLoaded) {
                              final data = state.data
                                  .where((file) => file['name']
                                      .toString()
                                      .toLowerCase()
                                      .contains(controller.searchText))
                                  .toList();

                              if (data.isEmpty) {
                                return Center(
                                  child: Lottie.asset(
                'assets/Animation - 1740514545687.json',
                height: 28.h,
                fit: BoxFit.contain,
              )
                                );
                              }

                              return DataPart(
                                classId: controller.classId,
                                data: state.data,
                                type: "doctor",
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
