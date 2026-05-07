// path: features/note/model/problems_model.dart

import 'package:flutter/material.dart';

class ProblemsModel {
  final String date;
  final String description;
  final String status;
  final Color statusColorHex; // We'll pass color as int (hex code)

  ProblemsModel({
    required this.date,
    required this.description,
    required this.status,
    required this.statusColorHex,
  });
}
