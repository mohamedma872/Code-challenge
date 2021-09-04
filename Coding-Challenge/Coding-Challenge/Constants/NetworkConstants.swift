import Foundation

enum NetworkConstant {
    static var generalAppHeaders : [String : String] {
        return [
            "Accept" : "application/json"]
    }
    static var baseUrl = "https://poi-api.mytaxi.com/PoiService/poi/"

    enum ApiKey {
        static let appID = ""
        static let appKey = ""
    }
}
