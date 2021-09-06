import Foundation
import ObjectMapper
import RxSwift
enum NetworkResponse:String,Error {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String> {
    case success
    case failure(String)
}
protocol BaseNetworkManager{
    static var environment: NetworkEnvironment { get }
    var router: NetworkRouter {get set}
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>
}
extension BaseNetworkManager{
    // default implementation for handleNetworkResponse function
     func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
// Implementing SOLID - Interface Segregation
protocol TaxiNetworkProtocal : BaseNetworkManager {
    func getTaxi(northLatitude: Double,
                 eastLongitude: Double,
                 southLatitude: Double,
                 westLongitude: Double) -> Observable<TaxiModel?>
   
    
}
struct TaxiNetworkManager : TaxiNetworkProtocal{
    var router : NetworkRouter = Router<TaxiApi>()
    static let environment : NetworkEnvironment = .production
    func getTaxi(northLatitude: Double,
                 eastLongitude: Double,
                 southLatitude: Double,
                 westLongitude: Double) -> Observable<TaxiModel?> {
        return Observable.create { observer -> Disposable in
            router.request(TaxiApi.getTaxi(northLatitude: northLatitude, eastLongitude: eastLongitude, southLatitude: southLatitude, westLongitude: westLongitude)) { data, response, error in

                if let response = response as? HTTPURLResponse {
                    let result = self.handleNetworkResponse(response)
                    switch result {
                    case .success:
                        guard let responseData = data else {
                            observer.onError(NetworkResponse.noData)
                            return
                        }
                        do {
                            print(responseData)
                            let jsonData = try JSONSerialization.jsonObject(with:         responseData, options: .mutableContainers)
                           print(jsonData)
                            let taxiModel = try! JSONDecoder().decode(TaxiModel.self, from: responseData)
                            observer.onNext(taxiModel)
                        } catch {
                            print(error)
                          
                            observer.onError(NetworkResponse.unableToDecode)
                        }
                    case .failure(_):
                     
                        observer.onError(NetworkResponse.failed)
                    }
                }
            }
            return Disposables.create()
        }
    }



}
