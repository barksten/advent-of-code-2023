
import ArgumentParser
import Common
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

struct Limit {
  init(
    redLimit: Int = 12,
    greenLimit: Int = 13,
    blueLimit: Int = 14
  ) {
    self.redLimit = redLimit
    self.greenLimit = greenLimit
    self.blueLimit = blueLimit
  }
  
  let redLimit: Int
  let greenLimit: Int
  let blueLimit: Int
}

func validateGame(limit: Limit) -> (Game) -> Bool {
  { validateGame(limit: limit, game: $0) }
}

func validateGame(limit: Limit, game: Game) -> Bool {
  for set in game.sets {
    if set.redCount > limit.redLimit { return false }
    if set.greenCount > limit.greenLimit { return false }
    if set.blueCount > limit.blueLimit { return false }
  }
  return true
}

func solution(_ input: String) -> Int {
  let games = try! games.parse(input)
  let validGames = games.filter(validateGame(limit: Limit()))
  return validGames.map(\.id).reduce(0, +)
}

func findLimits(_ games: [Game]) -> [Limit] {
  games.map {
    let maxRed: Int = $0.sets.reduce(0, { acc, new in
      max(acc, new.redCount)
    })
    let maxGreen: Int = $0.sets.reduce(0, { acc, new in
      max(acc, new.greenCount)
    })
    let maxBlue: Int = $0.sets.reduce(0, { acc, new in
      max(acc, new.blueCount)
    })
    return Limit(redLimit: maxRed, greenLimit: maxGreen, blueLimit: maxBlue)
  }
}

func solutionBonus(_ input: String) -> Int {
  let games = try! games.parse(input)
  
  return findLimits(games)
    .map {
      $0.redLimit * $0.greenLimit * $0.blueLimit
    }
    .reduce(0, +)
}

@main
struct Day2: ParsableCommand {
  @Argument(help: "Specify the input")
  public var input: String

  public func run() throws {
    print(solution(input))
  }
}
