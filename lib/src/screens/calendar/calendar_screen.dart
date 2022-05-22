import 'package:admin_shop/src/components/arrow_widget.dart';
import 'package:admin_shop/src/components/headline_2_title.dart';
import 'package:admin_shop/src/components/headline_title.dart';
import 'package:admin_shop/src/utils/constante.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CalendarController _controller = CalendarController();
  String _dayFormat = 'EEE', _dateFormat = 'dd';

  void viewChanged(ViewChangedDetails viewChangedDetails) {
    if (_controller.view == CalendarView.day) {
      SchedulerBinding.instance!.addPostFrameCallback((Duration duration) {
        if (_dayFormat != 'EEEEE' || _dateFormat != 'dd') {
          setState(() {
            _dayFormat = 'EEEEE';
            _dateFormat = 'dd';
          });
        } else {
          return;
        }
      });
    } else {
      SchedulerBinding.instance!.addPostFrameCallback((Duration duration) {
        if (_dayFormat != 'EEE' || _dateFormat != 'dd') {
          setState(() {
            _dayFormat = 'EEE';
            _dateFormat = 'dd';
          });
        } else {
          return;
        }
      });
    }
  }

  _getMonthDate(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return 'January';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 70),
          const SizedBox(height: kDefaultPadding),
          const HeadlineTitle(title: 'Calendar'),
          const SizedBox(height: kDefaultPadding / 2),
          Row(
            children: const [
              SubTitle(title: 'Shoppy'),
              SizedBox(width: kDefaultPadding / 2),
              ArrowWidget(),
              SizedBox(width: kDefaultPadding / 2),
              SubTitle(title: 'Calendar'),
            ],
          ),
          const SizedBox(height: kDefaultPadding * 2),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding * 2,
              vertical: kDefaultPadding * 4,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: SfCalendar(
              initialDisplayDate: DateTime.now(),
              onViewChanged: viewChanged,
              view: CalendarView.month,
              cellBorderColor: Theme.of(context).colorScheme.surface,
              cellEndPadding: 5,
              headerHeight: 60,
              allowedViews: const [
                CalendarView.month,
                CalendarView.week,
                CalendarView.day,
                CalendarView.schedule,
              ],
              showNavigationArrow: true,
              allowViewNavigation: true,
              showDatePickerButton: true,
              scheduleViewMonthHeaderBuilder: (BuildContext buildContext,
                  ScheduleViewMonthHeaderDetails details) {
                final String monthName = _getMonthDate(details.date.month);
                return Stack(
                  children: [
                    Image(
                      image: ExactAssetImage('images/' + monthName + '.png'),
                      fit: BoxFit.cover,
                      width: details.bounds.width,
                      height: details.bounds.height,
                    ),
                    Positioned(
                      left: 55,
                      right: 0,
                      top: 20,
                      bottom: 0,
                      child: Text(
                        monthName + ' ' + details.date.year.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                );
              },
              timeSlotViewSettings: TimeSlotViewSettings(
                timeInterval: const Duration(hours: 2),
                timeIntervalHeight: 80,
                timeIntervalWidth: 100,
                timeTextStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              headerStyle: CalendarHeaderStyle(
                textAlign: TextAlign.center,
                backgroundColor: Theme.of(context).colorScheme.background,
                textStyle: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              viewHeaderStyle: ViewHeaderStyle(
                dayTextStyle: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
                backgroundColor: Theme.of(context).colorScheme.background,
                dateTextStyle: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              todayHighlightColor: kPrimaryColor,
              todayTextStyle: Theme.of(context)
                  .textTheme
                  .overline!
                  .copyWith(color: Colors.white),
              dataSource: MeetingDataSource(_getDataSource()),
              monthViewSettings: MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                showTrailingAndLeadingDates: false,
                monthCellStyle: MonthCellStyle(
                  textStyle: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
          ),
          const SizedBox(height: kDefaultPadding * 10),
        ],
      ),
    );
  }
}

List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));
  meetings.add(Meeting(
      'Conference', startTime, endTime, const Color(0xFF0F8644), false));
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
