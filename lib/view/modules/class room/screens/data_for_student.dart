import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:studify/core/constants/colors.dart';
import 'package:studify/view%20model/data/data_bloc.dart';
import 'package:studify/view/modules/class%20room/widgets/data_page_appbar.dart';
import 'package:studify/view/modules/class%20room/widgets/data_part.dart';
import 'package:studify/view/shared_widgets/search_field.dart';

class DataForStudents extends StatelessWidget {
  const DataForStudents({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DataBloc(),
        child: Builder(
          builder: (context) {
            var controller = context.read<DataBloc>();
            controller.add(GetData(controller.classId, ''));
            return Scaffold(
                appBar: DataPageAppbar(
                  classId: controller.classId,
                  type: "student",
                ),
                body: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
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
                      child: BlocListener<DataBloc, DataState>(
                        listener: (context, state) {
                          if (state is DataError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.msg)),
                            );
                          } else if (state is DataSuccess) {
                            controller.add(GetData(controller.classId, ''));
                          }
                        },
                        child: BlocBuilder<DataBloc, DataState>(
                          builder: (context, state) {
                            if (state is DataLoading) {
                              return  Center(
                                  child:  Lottie.asset(
              'assets/Animation - 1740512569959.json',
              height: 20.h,
              fit: BoxFit.contain,
            ));
                            } else if (state is DataError) {
                              return Center(
                                child: Text(
                                  'Error: ${state.msg}',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: MyColors().mainColors),
                                ),
                              );
                            } else if (state is DataLoaded) {
                              final data = state.data;

                              if (data.isEmpty) {
                                return Center(
                                  child:  Lottie.asset(
                'assets/Animation - 1740514545687.json',
                height: 28.h,
                fit: BoxFit.contain,
              )
                                );
                              }

                              return DataPart(
                                  classId: controller.classId,
                                  data: data,
                                  type: "student");
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ));
          },
        ));
  }
}
