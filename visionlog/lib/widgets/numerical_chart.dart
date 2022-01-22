import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:visionlog/provider/dream_documents_provider.dart';

import 'dream.dart';

class NumericalChart extends StatelessWidget {
  NumericalChart(this.dateSelected, {Key? key}) : super(key: key);
  final DateTime dateSelected;

  @override
  Widget build(BuildContext context) {
    var docs = context
        .watch<Documents>()
        .documents!
        .map((dream) =>
        Dream.fromMap(dream.data() as Map<String, dynamic>,
            reference: dream.reference))
        .where((dream) => dream.datetime.isAfter(dateSelected))
        .toList();

    return Container(
      child: ListView(
          children: _buildData(docs)
      ),
    );
  }

  _buildData(List<Dream>? docs) {
    double terribleCount = 0,
        badCount = 0,
        averageCount = 0,
        okayCount = 0,
        fantasticCount = 0,
        lucidCount = 0,
        nightmareCount = 0,
        recurringCount = 0,
        continuousCount = 0;

    if (docs != null) {
      docs.forEach((Dream dream) {
        switch (dream.feel) {
          case 'terrible':
            {
              terribleCount++;
            }
            break;
          case 'bad':
            {
              badCount++;
            }
            break;
          case 'average':
            {
              averageCount++;
            }
            break;
          case 'okay':
            {
              okayCount++;
            }
            break;
          case 'fantastic':
            {
              fantasticCount++;
            }
            break;
          default:
            {
              averageCount++;
            }
            break;
        }
        if (dream.isLucid) {
          lucidCount++;
        } else if (dream.isNightmare) {
          nightmareCount++;
        } else if (dream.isRecurring) {
          recurringCount++;
        } else if (dream.isContinuous) {
          continuousCount++;
        }
      });

      return [
        Text('Terrible: $terribleCount'),
        Text('Bad: $badCount'),
        Text('Average: $averageCount'),
        Text('Okay: $okayCount'),
        Text('Fantastic: $fantasticCount'),
        Text('Lucid: $lucidCount'),
        Text('Nightmare: $nightmareCount'),
        Text('Recurring: $recurringCount'),
        Text('Continuous: $continuousCount'),
        Text('Total Amount of Dreams: ${docs.length}'),
      ];
    }
  }
}