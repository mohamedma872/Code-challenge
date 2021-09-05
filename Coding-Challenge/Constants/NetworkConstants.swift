import Foundation

enum NetworkConstant {
    static var generalAppHeaders : [String : String] {
        return [
            "Accept" : "application/json"]
    }
    static var baseUrl = "https://poi-api.mytaxi.com/PoiService/poi/"
}
struct DEFAULT_HAMBURG_LOCATIONS {
    static let LATITUDE: Float = 53.5584898
    static let LONGITUDE: Float = 9.7873967
}
struct DEFAULT_HAMBURG_LOCATION_LIMITS {
    static let lat2: Float = 53.394655
    static let lon2: Float = 10.099891
    static let lat1: Float = 53.694865
    static let lon1: Float = 9.757589
}
