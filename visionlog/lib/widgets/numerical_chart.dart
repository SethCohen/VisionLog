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
        .map((dream) => Dream.fromMap(dream.data() as Map<String, dynamic>,
            reference: dream.reference))
        .where((dream) => dream.datetime.isAfter(dateSelected))
        .toList();

    return Container(
      child: ListView(
          padding: const EdgeInsets.all(16.0), children: _buildData(docs)),
    );
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
        } else {
          untaggedCount++;
        }
      });

      return [
        RichText(
          text: TextSpan(
            text: 'Total Amount of Dreams: ',
            style: TextStyle(fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                  text: '${docs.length}',
                  style: TextStyle(fontWeight: FontWeight.normal)),
            ],
          ),
        ),
        Divider(),
        Text('Dream Feel Count Distribution:',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        RichText(
          text: TextSpan(
            text: '\t\t\tTerrible: ',
            style: TextStyle(fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                  text: '$terribleCount',
                  style: TextStyle(fontWeight: FontWeight.normal)),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            text: '\t\t\tBad: ',
            style: TextStyle(fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                  text: '$badCount',
                  style: TextStyle(fontWeight: FontWeight.normal)),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            text: '\t\t\tAverage: ',
            style: TextStyle(fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                  text: '$averageCount',
                  style: TextStyle(fontWeight: FontWeight.normal)),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            text: '\t\t\tOkay: ',
            style: TextStyle(fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                  text: '$okayCount',
                  style: TextStyle(fontWeight: FontWeight.normal)),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            text: '\t\t\tFantastic: ',
            style: TextStyle(fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                  text: '$fantasticCount',
                  style: TextStyle(fontWeight: FontWeight.normal)),
            ],
          ),
        ),
        Divider(),
        Text('Dream Type Count Distribution:',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        RichText(
          text: TextSpan(
            text: '\t\t\tLucid: ',
            style: TextStyle(fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                  text: '$lucidCount',
                  style: TextStyle(fontWeight: FontWeight.normal)),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            text: '\t\t\tNightmare: ',
            style: TextStyle(fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                  text: '$nightmareCount',
                  style: TextStyle(fontWeight: FontWeight.normal)),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            text: '\t\t\tRecurring: ',
            style: TextStyle(fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                  text: '$recurringCount',
                  style: TextStyle(fontWeight: FontWeight.normal)),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            text: '\t\t\tContinuous: ',
            style: TextStyle(fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                  text: '$continuousCount',
                  style: TextStyle(fontWeight: FontWeight.normal)),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            text: '\t\t\tUntagged: ',
            style: TextStyle(fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                  text: '$untaggedCount',
                  style: TextStyle(fontWeight: FontWeight.normal)),
            ],
          ),
        )
      ];
    }
  }
}