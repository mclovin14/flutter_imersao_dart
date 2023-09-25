import 'package:flutter/material.dart';

import '../constants.dart';

class HoursPanel extends StatelessWidget {
  final List<int>? enabledHours;
  final int startTime;
  final int endTime;
  final ValueChanged<int> onHourPressed;
  const HoursPanel(
      {super.key,
      required this.startTime,
      required this.endTime,
      required this.onHourPressed,
      this.enabledHours});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selecione os horários de atendimento',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 16,
          ),
          Wrap(
            //componente com quebra de linha automaticamente
            spacing: 8,
            runSpacing: 16,
            children: [
              for (int i = startTime; i <= endTime; i++)
                TimeButton(
                  label: '${i.toString().padLeft(2, '0')}:00',
                  onHourPressed: onHourPressed,
                  value: i,
                  enabledHours: enabledHours,
                ),
            ],
          )
        ],
      ),
    );
  }
}

class TimeButton extends StatefulWidget {
  final List<int>? enabledHours;
  final String label;
  final int value;
  final ValueChanged<int> onHourPressed;

  const TimeButton(
      {super.key,
      required this.label,
      required this.value,
      required this.onHourPressed,
      this.enabledHours});

  @override
  State<TimeButton> createState() => _TimeButtonState();
}

class _TimeButtonState extends State<TimeButton> {
  var selected = false;

  @override
  Widget build(BuildContext context) {
    final textColor = selected ? ColorsConstants.white : ColorsConstants.grey;
    var buttonColor = selected ? ColorsConstants.brown : ColorsConstants.white;
    var buttonBorderColor =
        selected ? ColorsConstants.brown : ColorsConstants.grey;
    final TimeButton(:enabledHours, :value) = widget;

    final disabledHour = enabledHours != null && !enabledHours.contains(value);

    if (disabledHour) {
      buttonColor = Colors.grey[400]!;
    }

    return InkWell(
      onTap: disabledHour
          ? null
          : () {
              widget.onHourPressed(value);
              setState(() {
                selected = !selected;
              });
            },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 64,
        height: 36,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: buttonColor,
            border: Border.all(color: buttonBorderColor)),
        child: Center(
          child: Text(
            widget.label,
            style: TextStyle(
                color: textColor, fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
