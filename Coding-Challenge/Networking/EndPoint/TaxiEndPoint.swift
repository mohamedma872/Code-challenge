import Foundation

enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum TaxiApi {
    case getTaxi( northLatitude: Double,eastLongitude
: Double,southLatitude: Double,westLongitude: Double)
   
}

extension TaxiApi: EndPointType {
    
    var environmentBaseURL : String {
        switch TaxiNetworkManager.environment {
        case .production: return NetworkConstant.baseUrl
        case .qa: return NetworkConstant.baseUrl + "qaServer"
        case .staging: return NetworkConstant.baseUrl + "StagingServer"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .getTaxi:
            return "v1"
       
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getTaxi:
            return .get
    
        }
       
    }
    var task: HTTPTask {
        var params = [String:Double]()
        let headers = [ "Content-Type": "application/json" ]
        switch self {
        case .getTaxi(let northLatitude,let eastLongitude
                        ,let southLatitude,let westLongitude):
            params = ["p2Lat" : northLatitude,
                      "p1Lon": westLongitude, "p1Lat": southLatitude,"p2Lon":eastLongitude]
       
        }
        switch self {
        case .getTaxi:
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: params, additionHeaders: headers)
       
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
