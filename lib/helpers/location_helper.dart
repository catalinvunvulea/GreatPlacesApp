const GOOGLE_API_KEY = 'AIzaSyDsXpptSvO-xsdajg8Mi_xerV3SLeXkRYA'; //taken from https://console.cloud.google.com/google/maps-apis/start?_ga=2.50865455.700419560.1594969527-896973749.1594969527&pli=1&step=product_selection&project=centering-badge-283607


class LocationHelper {
  static String generateLocationPreviewImage({double latitude, double longitude}) {
    //link taken from https://developers.google.com/maps/documentation/maps-static/intro ; some modifications added
    //original link was: 
    //'https://maps.googleapis.com/maps/api/staticmap?center=Brooklyn+Bridge,New+York,NY&zoom=13&size=600x300&maptype=roadmap
//&markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:G%7C40.711614,-74.012318
//&markers=color:red%7Clabel:C%7C40.718217,-73.998284
//&key=YOUR_API_KEY'
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }
}