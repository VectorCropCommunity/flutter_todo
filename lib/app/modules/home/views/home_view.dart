import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_todo/app/modules/components/constants.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:flutter_todo/app/modules/components/button.dart';
import 'package:flutter_todo/app/modules/components/check_box_list.dart';
import 'package:flutter_todo/app/modules/components/gap.dart';
import 'package:flutter_todo/app/modules/components/styles.dart';
import 'package:lottie/lottie.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(
          bottom: 24,
          left: 16,
          right: 16,
        ),
        height: 56,
        child: button(() {
          // Get.toNamed(Routes.ADD);
          // controller.createData();

          controller.timeController.text = DateFormat(DateFormat.HOUR_MINUTE)
              .format(controller.newDate.value);
          Get.bottomSheet(
            BottomSheet(
              onClosing: () {},
              builder: (BuildContext context) {
                return Container(
                  width: Get.width,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Task Title *",
                          style: sideTextStyle,
                        ),
                        gap(8),
                        Obx(
                          () => TextField(
                            onChanged: (val) {
                              controller.title.value = val;
                            },
                            maxLength: 20,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: "Task Title",
                                filled: true,
                                suffixIcon: controller.title.isEmpty
                                    ? const Icon(
                                        Icons.warning,
                                        color: Colors.orange,
                                      )
                                    : const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ),
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.normal),
                                fillColor: Colors.white),
                          ),
                        ),
                        gap(24),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Category *",
                              style: sideTextStyle,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                  radius: 22.5,
                                  backgroundColor: const Color(COL_NOTES),
                                  child: Obx(
                                    () => IconButton(
                                      onPressed: () {
                                        controller.changeCat(1);
                                      },
                                      isSelected:
                                          controller.selectCatIndex.value == 1,
                                      icon: const Icon(Icons.note_outlined),
                                      selectedIcon: const Icon(Icons.note),
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                  radius: 22.5,
                                  backgroundColor: const Color(COL_DATE),
                                  child: Obx(
                                    () => IconButton(
                                      onPressed: () {
                                        controller.changeCat(2);
                                      },
                                      isSelected:
                                          controller.selectCatIndex.value == 2,
                                      selectedIcon:
                                          const Icon(Icons.date_range),
                                      icon:
                                          const Icon(Icons.date_range_outlined),
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                  radius: 22.5,
                                  backgroundColor: const Color(COL_CHAMP),
                                  child: Obx(
                                    () => IconButton(
                                      onPressed: () {
                                        controller.changeCat(3);
                                      },
                                      isSelected:
                                          controller.selectCatIndex.value == 3,
                                      icon: const Icon(
                                          Icons.leaderboard_outlined),
                                      selectedIcon:
                                          const Icon(Icons.leaderboard),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        gap(24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Expanded(
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Text(
                            //         "Completion Date",
                            //         style: sideTextStyle,
                            //       ),
                            //       gap(8),
                            //       TextField(
                            //         controller: controller.dateController,
                            //         onTap: () {
                            //           showDatePicker(
                            //                   context: context,
                            //                   initialDate: DateTime.now(),
                            //                   firstDate: DateTime.now(),
                            //                   lastDate: DateTime.now().add(
                            //                       const Duration(days: 14)))
                            //               .then((value) =>
                            //                   controller.changeDate(value!));
                            //         },
                            //         decoration: const InputDecoration(
                            //             suffixIcon: Icon(Icons.calendar_today),
                            //             border: OutlineInputBorder(),
                            //             hintText: "Pick Date",
                            //             filled: true,
                            //             hintStyle: TextStyle(
                            //                 fontWeight: FontWeight.normal),
                            //             fillColor: Colors.white),
                            //       )
                            //     ],
                            //   ),
                            // ),
                            // const SizedBox(
                            //   width: 8,
                            // ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Completion Time *",
                                    style: sideTextStyle,
                                  ),
                                  gap(8),
                                  TextField(
                                    controller: controller.timeController,
                                    onTap: () {
                                      showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now())
                                          .then((value) =>
                                              controller.changeTime(value!));
                                    },
                                    decoration: const InputDecoration(
                                        suffixIcon: Icon(Icons.schedule),
                                        border: OutlineInputBorder(),
                                        hintText: "Pick Time",
                                        filled: true,
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.normal),
                                        fillColor: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        gap(24),
                        Text(
                          "Notes",
                          style: sideTextStyle,
                        ),
                        gap(8),
                        const TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Notes",
                              filled: true,
                              hintStyle:
                                  TextStyle(fontWeight: FontWeight.normal),
                              fillColor: Colors.white),
                          keyboardType: TextInputType.multiline,
                          maxLines: 7,
                        ),
                        gap(24),
                        Container(
                          height: 56,
                          width: Get.width,
                          child: button(() => controller.createData(),
                              "Add New Task", controller.saving.value),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }, "Add New Task", false),
      ),
      backgroundColor: const Color(COL_BG),
      appBar: AppBar(
        backgroundColor: const Color(COL_PRIMARY),
        toolbarHeight: 96,
        title: const Text(
          "Todo List",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationVersion:
                    "1.0.0\n\nBy Muhammed Shabeer OP\nvectorcrop.com",
                applicationIcon: const Image(
                  image: AssetImage("assets/logo.png"),
                  height: 40,
                ),
                applicationName: "My Todo",
              );
            },
            icon: Icon(Icons.info_outline_rounded),
          )
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(DateTime.now()),
              style: sideTextStyle,
            ),
            gap(24),
            Obx(() => controller.pendingTodo.isEmpty &&
                    controller.completedTodo.isEmpty
                ? Lottie.asset("assets/lottie.json")
                : Container()),
            Obx(
              () => ListView.builder(
                itemCount: controller.pendingTodo.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Obx(() => Column(
                        children: [
                          list(controller.pendingTodo[index], index,
                              controller.pendingTodo.length, controller),
                          index != controller.pendingTodo.length - 1
                              ? const Divider(
                                  height: 0,
                                )
                              : Container()
                        ],
                      ));
                },
              ),
            ),
            Obx(
              () => gap(controller.completedTodo.isNotEmpty &&
                      controller.pendingTodo.isEmpty
                  ? 0
                  : 24),
            ),
            Obx(() => controller.completedTodo.isNotEmpty
                ? Text("Completed", style: sideTextStyle)
                : Container()),
            gap(24),
            Obx(
              () => ListView.builder(
                itemCount: controller.completedTodo.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Obx(() => Column(
                        children: [
                          list(controller.completedTodo[index], index,
                              controller.completedTodo.length, controller),
                          index != controller.completedTodo.length - 1
                              ? const Divider(
                                  height: 0,
                                )
                              : Container()
                        ],
                      ));
                },
              ),
            )
          ],
        ),
      ),
    );

    // return Scaffold(
    //   backgroundColor: const Color(0xffF1F5F9),
    //   bottomNavigationBar: Container(
    //       margin: const EdgeInsets.only(
    //         bottom: 24,
    //         left: 16,
    //         right: 16,
    //       ),
    //       height: 56,
    //       child: button(() {
    //         Get.toNamed(Routes.ADD);
    //       }, "Add New Task", false)),
    //   body: Stack(
    //     clipBehavior: Clip.antiAliasWithSaveLayer,
    //     children: [
    //       Column(
    //         children: [
    //           Expanded(
    //             flex: 1,
    //             child: Container(
    //               color: const Color(0xff4A3780),
    //             ),
    //           ),
    //           Expanded(
    //             flex: 3,
    //             child: Container(),
    //           ),
    //         ],
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.all(16.0),
    //         child: SingleChildScrollView(
    //           physics: const ClampingScrollPhysics(),
    //           child: Column(
    //             children: [
    //               Text(
    //                 DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY)
    //                     .format(DateTime.now()),
    //                 style: const TextStyle(color: Colors.white, fontSize: 16),
    //               ),
    //               const SizedBox(
    //                 height: 42,
    //               ),
    //               const Text(
    //                 "My Todo List",
    //                 style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     fontSize: 30,
    //                     color: Colors.white),
    //               ),
    //               const SizedBox(
    //                 height: 32,
    //               ),
    //               Obx(
    //                 () => ListView.builder(
    //                   itemCount: controller.pendingTodo.length,
    //                   shrinkWrap: true,
    //                   physics: const NeverScrollableScrollPhysics(),
    //                   itemBuilder: (BuildContext context, int index) {
    //                     return Obx(() => Column(
    //                           children: [
    //                             list(controller.pendingTodo[index], index,
    //                                 controller.pendingTodo.length, controller),
    //                             index != controller.pendingTodo.length - 1
    //                                 ? const Divider(
    //                                     height: 0,
    //                                   )
    //                                 : Container()
    //                           ],
    //                         ));
    //                   },
    //                 ),
    //               ),
    //               const SizedBox(
    //                 height: 50,
    //               ),
    //               const Align(
    //                 alignment: Alignment.topLeft,
    //                 child: Text(
    //                   "Completed",
    //                   style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     fontSize: 20,
    //                   ),
    //                 ),
    //               ),
    //               const SizedBox(
    //                 height: 20,
    //               ),
    //               Obx(
    //                 () => ListView.builder(
    //                   itemCount: controller.completedTodo.length,
    //                   shrinkWrap: true,
    //                   physics: const NeverScrollableScrollPhysics(),
    //                   itemBuilder: (BuildContext context, int index) {
    //                     return Obx(() => Column(
    //                           children: [
    //                             list(
    //                                 controller.completedTodo[index],
    //                                 index,
    //                                 controller.completedTodo.length,
    //                                 controller),
    //                             index != controller.completedTodo.length - 1
    //                                 ? const Divider(
    //                                     height: 0,
    //                                   )
    //                                 : Container()
    //                           ],
    //                         ));
    //                   },
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
