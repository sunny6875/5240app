import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:project_5240_frontend/utils/extension.dart';

class CustomCircleProgressbar extends StatelessWidget {
  final double radius;
  const CustomCircleProgressbar({super.key, this.radius = 20});

  @override
  Widget build(BuildContext context) {
    return NutsActivityIndicator(
      activeColor: Colors.white,
      inactiveColor: AppColors.green,
      tickCount: 24,
      relativeWidth: 0.4,
      radius: radius,
      startRatio: 0.7,
      animationDuration: const Duration(milliseconds: 500),
    );
  }
}
