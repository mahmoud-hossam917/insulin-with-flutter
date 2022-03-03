class DoseModel {
  List<DoseData> Doses = [];
  DoseModel.fromjeson(dynamic jeson) {
    jeson.forEach((element) {
      DoseData dose = DoseData.fromjeson(jeson: element);
      Doses.add(dose);
    });
  }
}

class DoseData {
  int? doseID;
  int? userID;
  String? doseDate;
  int? doseAmount;
  bool? isTaken;
  DoseData.fromjeson({required Map<String, dynamic> jeson}) {
    doseID = jeson['doseid'];
    userID = jeson['userid'];
    doseDate = jeson['dosedate'];
    doseAmount = jeson['doseamount'];
    isTaken = jeson['istaken'];
  }
}
