import 'package:barbershop/src/core/ui/barbershop_icons.dart';
import 'package:barbershop/src/core/ui/constants.dart';
import 'package:barbershop/src/core/ui/widgets/avatar_widget.dart';
import 'package:barbershop/src/core/ui/widgets/hours_panel.dart';
import 'package:barbershop/src/features/schedule/widgets/schedule_calendar.dart';
import 'package:flutter/material.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar um cliente'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              children: [
                const AvatarWidget(hideUploadButton: true),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'Nome e Sobrenome',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 37,
                ),
                TextFormField(
                  decoration: const InputDecoration(label: Text('Cliente')),
                ),
                const SizedBox(
                  height: 32,
                ),
                TextFormField(
                  readOnly: true,
                  decoration: const InputDecoration(
                      label: Text('Selecione uma data'),
                      hintText: 'Selecione uma data',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      suffixIcon: Icon(
                        BarbershopIcons.calendar,
                        color: ColorsConstants.brown,
                        size: 18,
                      )),
                ),
                const SizedBox(
                  height: 32,
                ),
                const ScheduleCalendar(),
                const SizedBox(
                  height: 24,
                ),
                HoursPanel(
                  startTime: 6,
                  endTime: 23,
                  onHourPressed: (hour) {},
                  enabledHours: const [6, 7, 8],
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    child: const Text('AGENDAR'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
