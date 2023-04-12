import 'package:flutter/material.dart';

import '../models/session.dart';
import 'firebase_controllers.dart';

class SessionsController{
  static registerNewSession(
      BuildContext context, Session session) async {
      AppConfig.sessionsRef.child(session.specialistId).child(session.id).set(session.toMap());
  }
}