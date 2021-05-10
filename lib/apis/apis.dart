class APi {
  //10.10.50.50:2750
  static List<Map<String, dynamic>> user = const [
    {"url": "10.10.50.50:2750", "route": "Client"},
    {"url": "10.10.50.50:2750", "route": "Birthday"},
  ];

  static List<Map<String, dynamic>> system = const [
    {"url": "10.10.50.50:2750", "route": "Money"},
    {"url": "localhost:5000", "route": "Insert"},
    {"url": "localhost:5000", "route": "Group"},
  ];
}
