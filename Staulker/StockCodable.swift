// Decoder means it can Decode itself from it's JSON representation
// struct was giving unresolved identifier errors so switched to class
class StockCodable: Codable {
  
  let c: Float
  let h: Float
  let l: Float
  let o: Float
  let pc: Float
  let t: Int
}

