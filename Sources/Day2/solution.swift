
import ArgumentParser
import Foundation
import Parsing


struct Game {
  let id: Int
  let sets: [GameSet]
}

struct GameSet {
  let redCount, greenCount, blueCount: Int
}

struct Pickup {
  let count: Int
  let color: Color
}

enum Color {
  case red, green, blue
}


let pickup = Parse(input: Substring.self, Pickup.init(count:color:)) {
  Int.parser()
  " "
  OneOf {
    "red".map { Color.red }
    "green".map { Color.green }
    "blue".map { Color.blue }
  }
}

let pickups = Parse() {
  Many {
    " "
    pickup
  } separator: {
    ","
  }
  .map { pickups in
    GameSet(
      redCount: count(pickups: pickups, color: .red),
      greenCount: count(pickups: pickups, color: .green),
      blueCount: count(pickups: pickups, color: .blue)
    )
  }
}

func count(pickups: [Pickup], color: Color) -> Int {
  let count = pickups
    .filter { $0.color == color }
    .map { $0.count }
    .reduce(0, +)
  return count
}

let game = Parse(Game.init(id:sets:)) {
  "Game "
  Digits()
  ":"
  Many {
    pickups
  } separator: {
    ";"
  }
}

let games = Many {
  game
} separator: {
  "\n"
} terminator: {
  "\n"
}

func validateGame(game: Game) -> Bool {
  for set in game.sets {
    if set.redCount > 12 { return false }
    if set.greenCount > 13 { return false }
    if set.blueCount > 14 { return false }
  }
  return true
}

func solution(_ input: String) -> Int {
  let games = try! games.parse(input)
  let validGames = games.filter(validateGame(game:))
  return validGames.map(\.id).reduce(0, +)
}

func loadInput() -> String {
  guard let path = Bundle.module.url(forResource: "input", withExtension: "txt") else {
    fatalError("Missing file")
  }
  let data: Data = try! Data(contentsOf: path)
  return String(data: data, encoding: .utf8)!
}

@main
struct Day2: ParsableCommand {
  @Argument(help: "Specify the input")
  public var input: String

  public func run() throws {
    print(solution(input))
  }
}
