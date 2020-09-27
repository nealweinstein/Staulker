import Foundation

class StockManager {
  
  static let urlSession = URLSession(configuration: .default)
  
  static func stock(ticker: String, completionHandler: @escaping (_ stock: StockCodable) -> Void) {
    
    let stockUrl = buildStockURL(ticker: ticker)
    let task = urlSession.dataTask(with: stockUrl) { (data, _, _) in
      let stockCodable = try! JSONDecoder().decode(StockCodable.self, from: data!)
      DispatchQueue.main.async {
        completionHandler(stockCodable)
      }
    }
    
    task.resume()
    
  }
  
//  static func downloadImage(url: URL, completionHandler: @escaping (_ image: UIImage) -> Void) {
//    let task = urlSession.dataTask(with: url) { data, _, _ in
//      let image = UIImage(data: data!)!
//      DispatchQueue.main.async {
//        completionHandler(image)
//      }
//    }
//
//    task.resume()
//  }
  
  private static func buildStockURL(ticker: String) -> URL {
//    var urlComponents = URLComponents()
//    urlComponents.scheme = "https"
//    urlComponents.host = "finnhub.io"
//    urlComponents.path = "api/v1/quote?symbol=\(ticker)&token=btdbmh748v6t4umjloig"
//    print(urlComponents.debugDescription)
//
//    return urlComponents.url!
//
    let apiPrefix = "https://finnhub.io/api/v1/quote?symbol="
    let apiSuffix = "&token=btdbmh748v6t4umjloig"
    let apiCall = apiPrefix + ticker + apiSuffix
    let url: URL = URL(string: apiCall)!
    return url

  }
}


