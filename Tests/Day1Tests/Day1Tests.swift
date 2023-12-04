import XCTest
@testable import Day1

final class Day1Tests: XCTestCase {
  func testExample1() throws {
    let input = """
1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet
"""
    let result = solution(input)
    XCTAssertEqual(result, 142)
  }
  
  func testInputfile() throws {
    let input = loadInput()
    XCTAssertEqual(input.count, 21985)
    let result = solution(input)
    XCTAssertEqual(result, 54630)
  }
  
  func testExample2() throws {
    let input = """
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen
"""
    let result = solution(input)
    XCTAssertEqual(result, 142)
    
  }
}
