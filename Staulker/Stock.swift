// this class is only for storing current price in user defaults

import Foundation

// codables cannot include other classes only primitives
struct Stock: Codable {
  
  var ticker: String
  var currentPrice: Float
  
}
