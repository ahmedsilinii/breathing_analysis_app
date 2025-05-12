class AppwriteConstants {
  static const String databaseId = '680e7e950034c74c82ae';
  static const String projectId = '680e72f5003a45449eac';
  static const String endPoint = 'http://10.0.2.2:80/v1';

  static const String userCollectionId = '6812524d002ee10cd667';
  static var diagnosisCollectionId = '682062700011e98de1a2';

  static const String medicalReportsBuckedId = '6820d28f0023e13cd053';
  static const String breathingRecordsBucketId = '6820d2a300233b5371d3';

  static String fileURL(String fileId, String bucketId) =>
      'http://localhost/v1/storage/buckets/$bucketId/files/$fileId/view?project=$projectId&project=$projectId&mode=admin';

  // Example URLs for testing
  // medical reports
  //'http://localhost/v1/storage/buckets/6820d28f0023e13cd053/files/68219485003ad9be15ab/view?project=680e72f5003a45449eac&project=680e72f5003a45449eac&mode=admin';
  // breathing records
  // http://localhost/v1/storage/buckets/6820d2a300233b5371d3/files/682195cc0012a341b2d7/view?project=680e72f5003a45449eac&project=680e72f5003a45449eac&mode=admin

  static String fileURLWithMode(String fileId, String bucketId, String mode) =>
      'http://localhost/v1/storage/buckets/$bucketId/files/$fileId/view?project=$projectId&project=$projectId&mode=$mode';
}
