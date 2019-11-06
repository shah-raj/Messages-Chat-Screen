import 'package:flutter/material.dart';

enum Options {
details,
search,
archive,
delete,
helpAndFeedback,
}

class OptionMenuChat extends StatelessWidget {
  @override
  Widget 
  
  build(BuildContext context) {
    return PopupMenuButton<Options>(
      onSelected: (Options result) {
        print(result);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
            const PopupMenuItem<Options>(
              value: Options.details,
              child: Text(
                'Details',
                style: TextStyle(fontFamily: 'Roboto'),
              ),
            ),
            const PopupMenuItem<Options>(
              value: Options.search,
              child: Text(
                'Search',
                style: TextStyle(fontFamily: 'Roboto'),
              ),
            ),
            const PopupMenuItem<Options>(
              value: Options.archive,
              child: Text(
                'Archive',
                style: TextStyle(fontFamily: 'Roboto'),
              ),
            ),
            const PopupMenuItem<Options>(
              value: Options.delete,
              child: Text(
                'Delete',
                style: TextStyle(fontFamily: 'Roboto'),
              ),
            ),
            const PopupMenuItem<Options>(
              value: Options.helpAndFeedback,
              child: Text(
                'Help & Feedback',
                style: TextStyle(fontFamily: 'Roboto'),
              ),
            ),
            
          ],
    );
  }
}
