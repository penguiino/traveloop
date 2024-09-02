import 'package:flutter/material.dart';
import '../models/container.dart';
import '../utils/constants.dart';

class ContainerWidget extends StatelessWidget {
  final TripContainer container;
  final VoidCallback? onEdit;
  final VoidCallback? onViewDetails;

  const ContainerWidget({
    super.key,
    required this.container,
    this.onEdit,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      elevation: 4.0,
      child: InkWell(
        onTap: onViewDetails,
        child: Padding(
          padding: defaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                container.title,
                style: headingStyle,
              ),
              const SizedBox(height: 8.0),
              Text(
                'Type: ${container.type}',
                style: bodyStyle.copyWith(color: secondaryColor),
              ),
              const SizedBox(height: 8.0),
              Text(
                container.details,
                style: bodyStyle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (container.subContainers.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: container.subContainers.map((sub) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          '- ${sub.title}',
                          style: bodyStyle.copyWith(color: accentColor),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              if (onEdit != null)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: onEdit,
                    child: const Text('Edit', style: TextStyle(color: primaryColor)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
