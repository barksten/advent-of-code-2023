import Foundation

public func loadInput(from bundle: Bundle) -> String {
  guard let path = bundle.url(forResource: "input", withExtension: "txt") else {
    fatalError("Missing file")
  }
  let data: Data = try! Data(contentsOf: path)
  return String(data: data, encoding: .utf8)!
}
