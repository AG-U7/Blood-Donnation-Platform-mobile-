import 'package:flutter/material.dart';

class DataService {
  // Mock data issu de DonorFeed.tsx
  static const List<Map<String, dynamic>> demandesUrgentes = [
    {
      "id": 1,
      "hospital": "CHU Yalgado Ouédraogo",
      "group": "O+",
      "urgency": "critical",
      "distance": "2.5 km",
      "description": "Urgence accident de la route. Besoin immédiat de 3 poches.",
    },
    {
      "id": 2,
      "hospital": "Clinique Sandof",
      "group": "A-",
      "urgency": "moderate",
      "distance": "5.1 km",
      "description": "Intervention chirurgicale programmée. Besoin de 2 poches.",
    },
    {
      "id": 3,
      "hospital": "CMA Pissy",
      "group": "B+",
      "urgency": "critical",
      "distance": "7.8 km",
      "description": "Complication accouchement. Besoin urgent.",
    },
  ];

  // Mock data issu de HospitalDashboard.tsx
  static const List<Map<String, dynamic>> hospitalStats = [
    {"label": "Demandes actives", "value": "3", "color": "orange"},
    {"label": "Dons reçus (Ce mois)", "value": "145", "color": "green"},
    {"label": "Taux de réponse", "value": "87%", "color": "red"},
    {"label": "Total donneurs", "value": "1,204", "color": "black"},
  ];

  static const List<Map<String, dynamic>> recentRequests = [
    {"id": 1, "group": "O+", "qty": 3, "urgency": "critical", "status": "active", "date": "Il y a 2h"},
    {"id": 2, "group": "A-", "qty": 1, "urgency": "moderate", "status": "fulfilled", "date": "Hier"},
    {"id": 3, "group": "B+", "qty": 2, "urgency": "low", "status": "active", "date": "Hier"},
    {"id": 4, "group": "AB+", "qty": 4, "urgency": "critical", "status": "fulfilled", "date": "Il y a 3j"},
  ];
}
