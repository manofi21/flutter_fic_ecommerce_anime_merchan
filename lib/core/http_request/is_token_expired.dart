bool isTokenExpired(int statusCode) {
  return statusCode == 401 || statusCode == 403 || statusCode == 4001;
}
