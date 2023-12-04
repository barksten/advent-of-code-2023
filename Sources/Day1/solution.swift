
import ArgumentParser
import Foundation

enum numbers: String {
  case one = "one"
  case two = "two"
  case three = "three"
  case four = "four"
  case five = "five"
  case six = "six"
  case seven = "seven"
  case eight = "eight"
  case nine = "nine"
}

func firstAndLastDigit(input: any StringProtocol) -> (Int, Int) {
  let numbers = Array(input)
    .compactMap { $0.wholeNumberValue }
  return (numbers.first!, numbers.last!)
}

func combine(first: Int, last: Int) -> Int {
  return 10 * first + last
}

func solution(_ input: String) -> Int {
  return input
    .split(separator: "\n")
    .map(firstAndLastDigit(input:))
    .map(combine(first:last:))
    .reduce(0, +)
}

func loadInput() -> String {
  guard let path = Bundle.module.url(forResource: "input", withExtension: "txt") else {
    fatalError("Missing file")
  }
  let data: Data = try! Data(contentsOf: path)
  return String(data: data, encoding: .utf8)!
}

@main
struct Day1: ParsableCommand {
  @Argument(help: "Specify the input")
  public var input: String

  public func run() throws {
    print(solution(input))
  }
}
