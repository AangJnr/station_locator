
void exportData() async {
  //final firestoreInstance = Firestore.instance;

  print('Start export data');

  /* UPDATED_DATA.forEach((object) {

    object.forEach((regionName, listOfStations) {
      listOfStations.forEach((station)   {
        var stationData = Map<String, dynamic>.from(station);
        stationData.putIfAbsent('region', () => regionName);


      firestoreInstance.collection("station_database").add(stationData);


      });
    });
   }); */

    print('Done exporting data!');
}
