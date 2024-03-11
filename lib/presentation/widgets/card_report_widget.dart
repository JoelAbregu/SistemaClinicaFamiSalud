import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../config/theme/apptheme.dart';

class CardReport extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback function;
  final Widget numberReport;
  const CardReport({
    super.key,
    required this.query,
    required this.title,
    required this.image,
    required this.function,
    required this.numberReport,
  });
  final MediaQueryData query;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: query.size.width * 0.65,
          constraints: const BoxConstraints(maxWidth: 266),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: LinearGradient(
                  colors: [AppTheme.colorTertiary, Colors.white]),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0.2,
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: SizedBox(
                    width: 110, height: 105, child: Lottie.asset(image)),
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text("Reportes generados",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 10, color: Colors.grey.shade600)),
                    const SizedBox(
                      height: 5,
                    ),
                    numberReport,
                  ])
            ],
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        GestureDetector(
          onTap: function,
          child: Container(
            width: 90,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.green,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0.2,
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ]),
            child: const Icon(Icons.add_circle_outline,
                color: Colors.white, size: 40),
          ),
        ),
      ],
    );
  }
}
