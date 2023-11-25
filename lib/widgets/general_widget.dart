import 'package:flutter/material.dart';
import 'package:onanmedia_test/shared/utils/global_variables.dart';

class GeneralWidgets {
  static showLoadingWidgetContainer(
    BuildContext context,
  ) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)), //this right here
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 5,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator.adaptive(),
                    Text('Loading...'),
                  ],
                ),
              ),
            ),
          );
        });
  }

  static showMessageAlert(
    BuildContext context,
    String content,
    bool isSuccess,
  ) {
    Navigator.pop(context);
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width / 8,
                    foregroundColor: Colors.transparent,
                    child: ClipOval(
                      child: Image.asset(
                        (isSuccess)
                            ? GlobalVariables.successImage
                            : GlobalVariables.failedImage,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(content, textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: GlobalVariables.baseColor),
                      onPressed: () => Navigator.of(context)
                        ..pop()
                        ..pop(),
                      child: const Text("OK"),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
