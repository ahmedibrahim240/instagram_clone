//todo assetsRootes
// ignore_for_file: unused_element

const String imageAssetsRoot = "assets/images/";
const String iconAssetsRoot = "assets/icons/";
const String svgAssetsRoot = "assets/svg/";
const String jsonAssetsRoot = "assets/json/";

//*icons

//!ImagesPaTh

//**SvgPath */
final String instagramSvg = _getSvgPath('ic_instagram.svg');
//!ImagesJsonPaTh

//todo Get paths
String _getImagePath(String fileName) {
  return imageAssetsRoot + fileName;
}

String _getIconPath(String fileName) {
  return iconAssetsRoot + fileName;
}

String _getJsonIconPath(String fileName) {
  return jsonAssetsRoot + fileName;
}

String _getSvgPath(String fileName) {
  return svgAssetsRoot + fileName;
}
