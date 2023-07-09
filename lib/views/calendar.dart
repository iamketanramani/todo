import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:todo/resource/app_assets.dart';
import 'package:todo/resource/app_helper.dart';
import 'package:todo/resource/app_strings.dart';
import 'package:todo/views/primary_button.dart';
import 'package:todo/views/secondary_button.dart';

class Calendar extends StatefulWidget {
  final String? minDate, maxDate;
  final Function(String date)? onDateSelected;

  const Calendar({
    super.key,
    this.minDate = '',
    this.maxDate = '',
    this.onDateSelected,
  });

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  var dateController = DateRangePickerController();

  var selectedDate = '';
  var selectedMonth = '';

  DateTime? minDate;
  DateTime? maxDate;

  @override
  void initState() {
    super.initState();
    /* if (widget.minDate!.isNotEmpty) {
      dateController.displayDate = AppHelper.stringToDateTime(widget.minDate!,
          format: AppStrings.dfYMD);
    } else {
      dateController.displayDate = DateTime.now();
    } */

    if (widget.minDate!.isNotEmpty) {
      minDate = AppHelper.stringToDateTime(
        widget.minDate!,
        format: AppStrings.dfYMD,
      );
    }

    if (widget.maxDate!.isNotEmpty) {
      maxDate = AppHelper.stringToDateTime(
        widget.maxDate!,
        format: AppStrings.dfYMD,
      );
    }

    setState(() {});
  }

  String getToday() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.minDate!.isEmpty && widget.maxDate!.isEmpty)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: SecondaryButton(
                      height: 40,
                      textSize: 13,
                      text: AppStrings.strToday,
                      onPressed: () {
                        var today = DateTime.now();
                        dateController.selectedDate = today;
                        selectedDate =
                            DateFormat(AppStrings.dfYMD).format(today);
                        setState(() {});
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: PrimaryButton(
                      width: 80,
                      height: 40,
                      textSize: 13,
                      text: AppStrings.strNextMonday,
                      onPressed: () {
                        var today = DateTime.now();
                        DateTime nextMonday = today.next(DateTime.monday);
                        dateController.selectedDate = nextMonday;
                        selectedDate =
                            DateFormat(AppStrings.dfYMD).format(nextMonday);
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: SecondaryButton(
                      height: 40,
                      textSize: 13,
                      text: AppStrings.strNextTuesday,
                      onPressed: () {
                        var today = DateTime.now();
                        DateTime nextTuesday = today.next(DateTime.tuesday);
                        dateController.selectedDate = nextTuesday;
                        selectedDate =
                            DateFormat(AppStrings.dfYMD).format(nextTuesday);
                        setState(() {});
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SecondaryButton(
                      width: 80,
                      height: 40,
                      textSize: 13,
                      text: AppStrings.strAfter1Week,
                      onPressed: () {
                        var after1Week =
                            DateTime.now().add(const Duration(days: 7));
                        dateController.selectedDate = after1Week;
                        selectedDate =
                            DateFormat(AppStrings.dfYMD).format(after1Week);
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        if (widget.minDate!.isNotEmpty && widget.maxDate!.isEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: PrimaryButton(
                  height: 40,
                  textSize: 13,
                  text: AppStrings.strNoDate,
                  onPressed: () {
                    dateController.selectedDate =
                        DateTime(1900, 01, 01, 0, 0, 0);
                    selectedDate = '';
                    setState(() {
                      dateController.displayDate = DateTime.now();
                    });
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SecondaryButton(
                  width: 80,
                  height: 40,
                  textSize: 13,
                  text: AppStrings.strToday,
                  onPressed: () {
                    var today = DateTime.now();
                    dateController.selectedDate = today;
                    selectedDate = DateFormat(AppStrings.dfYMD).format(today);
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                dateController.backward!.call();
              },
              splashRadius: 20,
              constraints: const BoxConstraints(
                maxHeight: 50,
                maxWidth: 50,
              ),
              icon: SvgPicture.asset(
                AppAssets.icCalendarPrev,
              ),
            ),
            const SizedBox(width: 20),
            Container(
              constraints: const BoxConstraints(minWidth: 80),
              child: Text(
                selectedMonth,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () {
                dateController.forward!.call();
              },
              splashRadius: 20,
              constraints: const BoxConstraints(
                maxHeight: 50,
                maxWidth: 50,
              ),
              icon: SvgPicture.asset(
                AppAssets.icCalendarNext,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 300,
          width: mediaQuery.size.width,
          child: SfDateRangePicker(
            minDate: minDate,
            maxDate: maxDate,
            view: DateRangePickerView.month,
            selectionMode: DateRangePickerSelectionMode.single,
            controller: dateController,
            headerHeight: 0, // This will hide Month and Year
            monthViewSettings: const DateRangePickerMonthViewSettings(
              dayFormat: 'EEE', // Displays days in 3 digit like SUN
            ),
            onViewChanged: (dateRangePickerViewChangedArgs) {
              SchedulerBinding.instance
                  .addPostFrameCallback((Duration duration) {
                var selectedDate =
                    dateRangePickerViewChangedArgs.visibleDateRange.startDate;
                selectedMonth = AppHelper.changeDateForat(
                    selectedDate.toString(),
                    fromFormat: AppStrings.dfIso,
                    toformat: 'MMM yyyy');
                setState(() {});
              });
            },
            onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
              String dt = dateRangePickerSelectionChangedArgs.value.toString();
              String date = AppHelper.changeDateForat(dt,
                  fromFormat: AppStrings.dfIso, toformat: AppStrings.dfYMD);
              selectedDate = date;
              setState(() {});
            },
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            SvgPicture.asset(AppAssets.icCalendar),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                selectedDate.isNotEmpty
                    ? AppHelper.changeDateForat(
                        selectedDate,
                        fromFormat: AppStrings.dfYMD,
                        toformat: AppStrings.dfCalendarDialog,
                      )
                    : AppStrings.strNoDate,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 10),
            SecondaryButton(
              width: 80,
              height: 40,
              textSize: 13,
              text: AppStrings.strCancel,
              onPressed: () {
                Get.back();
              },
            ),
            const SizedBox(width: 10),
            PrimaryButton(
              width: 80,
              height: 40,
              textSize: 13,
              text: AppStrings.strSave,
              onPressed: () {
                /* if (selectedDate.isNotEmpty) {
                  widget.onDateSelected!(selectedDate);
                  Get.back();
                } else {
                  Toast.show(context, AppStrings.strPleaseSelectDate);
                } */
                widget.onDateSelected!(selectedDate);
                Get.back();
              },
            ),
          ],
        ),
      ],
    );
  }
}

extension DateTimeExtension on DateTime {
  DateTime next(int day) {
    return add(
      Duration(
        days: (day - weekday) % DateTime.daysPerWeek,
      ),
    );
  }
}
