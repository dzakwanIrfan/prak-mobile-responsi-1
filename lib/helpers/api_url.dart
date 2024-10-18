class ApiUrl {
  static const String baseUrl = 'http://103.196.155.42/api';
  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listFasilitas = baseUrl + '/pariwisata/fasilitas';
  static const String createFasilitas = baseUrl + '/pariwisata/fasilitas';
  static String updateFasilitas(int id) {
    return baseUrl + '/pariwisata/fasilitas/' + id.toString() + '/update';
  }

  static String showFasilitas(int id) {
    return baseUrl + '/pariwisata/fasilitas/' + id.toString();
  }

  static String deleteFasilitas(int id) {
    return baseUrl + '/pariwisata/fasilitas/' + id.toString() + '/delete';
  }
}
