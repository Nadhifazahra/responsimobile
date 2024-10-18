class ApiUrl {
  static const String baseUrl = 'http://responsi.webwizards.my.id/api';
  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listPenerbit = baseUrl + '/buku/penerbit';
  static const String createPenerbit = baseUrl + '/buku/penerbit';
  static String updatePenerbit(int id) {
    return baseUrl + '/buku/penerbit/' + id.toString() + '/update';
  }

  static String showPenerbit(int id) {
    return baseUrl + '/buku/penerbit/' + id.toString();
  }

  static String deletePenerbit(int id) {
    return baseUrl + '/buku/penerbit/' + id.toString() + '/delete';
  }
}
