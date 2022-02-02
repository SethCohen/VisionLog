import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visionlog/providers/dream_documents_provider.dart';

import 'dream.dart';

class NumericalChart extends StatelessWidget {
  const NumericalChart(this.dateSelected, {Key? key}) : super(key: key);
  final DateTime dateSelected;

  @override
  Widget build(BuildContext context) {
    var docs = context
        .watch<Documents>()
        .documents!
        .map((dream) => Dream.fromMap(dream.data() as Map<String, dynamic>,
            reference: dream.reference))
        .where((dream) => dream.datetime.isAfter(dateSelected))
        .toList();

    return docs.isEmpty
        ? const Center(child: Text("No Data Found"))
        : ListView(
            padding: const EdgeInsets.all(16.0), children: _buildData(docs));
  }

  _buildData(List<Dream>? docs) {
    int terribleCount = 0,
        badCount = 0,
        averageCount = 0,
        okayCount = 0,
        fantasticCount = 0,
        lucidCount = 0,
        nightmareCount = 0,
        recurringCount = 0,
        continuousCount = 0,
        untaggedCount = 0;

    if (docs != null) {
      for (var dream in docs) {
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
        } else {
          untaggedCount++;
        }
      }

      return [
        RichText(
          text: TextSpan(
            text: 'Total Amount of Dreams: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                  text: '${docs.length}',
                  style: const TextStyle(fontWeight: FontWeight.normal)),
            ],
          ),
        ),
        const Divider(),
        RichText(
            text: TextSpan(
                text: 'Dream Feel Count Distribution:\n',
                style: const TextStyle(fontWeight: FontWeight.bold),
                children: <TextSpan>[
              TextSpan(
                  text: '\t\t\tTerrible: ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: '$terribleCount\n',
                        style: const TextStyle(fontWeight: FontWeight.normal))
                  ]),
              TextSpan(
                  text: '\t\t\tBad: ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: '$badCount\n',
                        style: const TextStyle(fontWeight: FontWeight.normal))
                  ]),
              TextSpan(
                  text: '\t\t\tAverage: ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: '$averageCount\n',
                        style: const TextStyle(fontWeight: FontWeight.normal))
                  ]),
              TextSpan(
                  text: '\t\t\tOkay: ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: '$okayCount\n',
                        style: const TextStyle(fontWeight: FontWeight.normal))
                  ]),
              TextSpan(
                  text: '\t\t\tFantastic: ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: '$fantasticCount',
                        style: const TextStyle(fontWeight: FontWeight.normal))
                  ])
            ])),
        const Divider(),
        RichText(
            text: TextSpan(
                text: 'Dream Type Count Distribution:\n',
                style: const TextStyle(fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                      text: '\t\t\tLucid: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: '$lucidCount\n',
                            style: const TextStyle(fontWeight: FontWeight.normal))
                      ]),
                  TextSpan(
                      text: '\t\t\tNightmare: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: '$nightmareCount\n',
                            style: const TextStyle(fontWeight: FontWeight.normal))
                      ]),
                  TextSpan(
                      text: '\t\t\tRecurring: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: '$recurringCount\n',
                            style: const TextStyle(fontWeight: FontWeight.normal))
                      ]),
                  TextSpan(
                      text: '\t\t\tContinuous: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: '$continuousCount\n',
                            style: const TextStyle(fontWeight: FontWeight.normal))
                      ]),
                  TextSpan(
                      text: '\t\t\tUntagged: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: '$untaggedCount',
                            style: const TextStyle(fontWeight: FontWeight.normal))
                      ])
                ]))
      ];
    }
  }
}