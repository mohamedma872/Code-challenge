import Foundation

enum NetworkConstant {
    static var generalAppHeaders : [String : String] {
        return [
            "Accept" : "application/json"]
    }
    static var baseUrl = "https://poi-api.mytaxi.com/PoiService/poi/"
}
struct DEFAULT_HAMBURG_LOCATIONS {
    static let LATITUDE: Double = 53.5584898
    static let LONGITUDE: Double = 9.7873967
}
struct DEFAULT_HAMBURG_LOCATION_LIMITS {
    static let lat2: Double = 53.394655
    static let lon2: Double = 10.099891
    static let lat1: Double = 53.694865
    static let lon1: Double = 9.757589
}
