import 'package:argo/argo.dart';
import 'package:pitchupfluttersample/app/ui/shared/top_menu/points_decoration_widget.dart';
import 'package:pitchupfluttersample/config/values/values.dart';
import 'package:flutter/material.dart';

class AppTitleWidget extends StatelessWidget {
  const AppTitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: getHorizontalPaddingMainPages(context),
        child: SizedBox(
          height: kSizeHeaderBar,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/logo.png'),
              ),
        
              // const PointsDecorationWidget(
              //   colors: [
              //    Colors.lightGreen,
              //     kCreamColor,
              //     kCreamColor,
              //     Colors.lightGreen,
                
              
              ConditionalResponsiveWidget<double>(
                conditionsMatch: const [
                  ConditionBreakpoint<double>.smallerThan(
                    value: 22,
                    breakpoint: 765,
                  ),
                  ConditionBreakpoint<double>.smallerThan(
                    value: 18,
                    breakpoint: 733,
                  ),
                  ConditionBreakpoint<double>.smallerThan(
                    value: 16,
                    breakpoint: 700,
                  ),
                  ConditionBreakpoint<double>.smallerThan(
                    value: 24,
                    breakpoint: 650,
                  ),
                ],
                builder: (ctx, match) {
                  final textStyle = match != null
                      ? Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontSize: match)
                      : Theme.of(context).textTheme.displaySmall;

                  return RichText(
                    text:
                        TextSpan(text: 'Melody', style: textStyle,),
                  );
                },
              )],
          ),
          
        ),
      ),
    );
  }
}
