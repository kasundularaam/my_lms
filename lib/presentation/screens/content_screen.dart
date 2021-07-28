import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_lms/logic/cubit/download_pdf_cubit/download_pdf_cubit.dart';
import 'package:my_lms/presentation/screens/widgets/error_msg_box.dart';
import 'package:sizer/sizer.dart';

import 'package:my_lms/core/constants/my_colors.dart';
import 'package:my_lms/core/constants/my_styles.dart';
import 'package:my_lms/core/screen_arguments/content_screen_args.dart';
import 'package:my_lms/presentation/router/app_router.dart';

class ContentScreen extends StatefulWidget {
  final ContentScreenArgs args;
  const ContentScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DownloadPdfCubit(),
      child: Scaffold(
        backgroundColor: MyColors.backgroundWhite,
        body: ListView(
          padding: EdgeInsets.all(0),
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              decoration: BoxDecoration(
                color: MyColors.offWhite,
                boxShadow: [MyStyles.boxShadow],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.w),
                  bottomRight: Radius.circular(10.w),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.w),
                  bottomRight: Radius.circular(10.w),
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        widget.args.contentName,
                        style: TextStyle(
                            color: MyColors.accentColor,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        width: 100.w,
                        padding: EdgeInsets.all(5.w),
                        decoration: BoxDecoration(
                          color: MyColors.white,
                          borderRadius: BorderRadius.circular(5.w),
                          boxShadow: [MyStyles.boxShadow],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Subject: ${widget.args.subjectName}",
                              style: TextStyle(
                                  color: MyColors.shadedBlack,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              "Module: ${widget.args.moduleName}",
                              style: TextStyle(
                                  color: MyColors.shadedBlack,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              "Content: ${widget.args.contentName}",
                              style: TextStyle(
                                  color: MyColors.shadedBlack,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      BlocBuilder<DownloadPdfCubit, DownloadPdfState>(
                        builder: (context, state) {
                          if (state is DownloadPdfInitial) {
                            return GestureDetector(
                              onTap: () =>
                                  BlocProvider.of<DownloadPdfCubit>(context)
                                      .downloadPdf(
                                          moduleId: widget.args.moduleId,
                                          contentId: widget.args.contentId),
                              child: Container(
                                padding: EdgeInsets.all(5.w),
                                decoration: BoxDecoration(
                                  color: MyColors.accentColor,
                                  borderRadius: BorderRadius.circular(5.w),
                                  boxShadow: [MyStyles.boxShadow],
                                ),
                                child: Center(
                                  child: Text(
                                    "Download Content As a PDF",
                                    style: TextStyle(
                                        color: MyColors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            );
                          } else if (state is DownloadPdfLoading) {
                            return Center(child: CircularProgressIndicator());
                          } else if (state is DownloadPdfFailed) {
                            return Column(
                              children: [
                                ErrorMsgBox(errorMsg: state.errorMsg),
                                SizedBox(
                                  height: 2.h,
                                ),
                                TextButton(
                                    onPressed: () =>
                                        BlocProvider.of<DownloadPdfCubit>(
                                                context)
                                            .emit(DownloadPdfInitial()),
                                    child: Text(
                                      "Retry",
                                      style: TextStyle(
                                        color: MyColors.accentColor,
                                        fontSize: 16.sp,
                                      ),
                                    )),
                              ],
                            );
                          } else {
                            return Center(
                              child: ErrorMsgBox(
                                  errorMsg: "unhandled state excecuted!"),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                AppRouter.workingScreen,
                arguments: widget.args,
              ),
              child: Container(
                padding: EdgeInsets.all(5.w),
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                decoration: BoxDecoration(
                  color: MyColors.accentColor,
                  borderRadius: BorderRadius.circular(5.w),
                  boxShadow: [MyStyles.boxShadow],
                ),
                child: Center(
                  child: Text(
                    "Start Working",
                    style: TextStyle(
                        color: MyColors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
