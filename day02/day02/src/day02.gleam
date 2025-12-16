import gleam/int
import gleam/list
import gleam/result
import gleam/string

fn parse(line: String) -> List(#(Int, Int)) {
  line
  |> string.split(",")
  |> list.map(fn(part) {
    let nums =
      part
      |> string.split("-")
      |> list.map(fn(n) { int.parse(n) |> result.unwrap(0) })
    #(list.first(nums) |> result.unwrap(0), list.last(nums) |> result.unwrap(0))
  })
}

fn is_valid_id(id: Int) -> Bool {
  let digits = int.to_string(id)
  let chars = string.length(digits)

  case chars % 2 {
    1 -> False
    _ -> {
      let pivot = chars / 2
      let left = string.slice(digits, 0, pivot)
      let right = string.slice(digits, pivot, string.length(digits))
      left == right
    }
  }
}

fn validate_ids(start: Int, end: Int) -> List(Int) {
  list.range(start, end + 1)
  |> list.filter(is_valid_id)
}

pub fn part1(lines: List(String)) -> Int {
  let ranges = parse(list.first(lines) |> result.unwrap(""))
  let invalid_ranges =
    list.flat_map(ranges, fn(range: #(Int, Int)) {
      validate_ids(range.0, range.1)
    })

  list.fold(invalid_ranges, 0, fn(acc, id) { acc + id })
}

pub fn part2(lines: List(String)) -> Int {
  let ranges = parse(list.first(lines) |> result.unwrap(""))
  let invalid_ranges =
    list.flat_map(ranges, fn(range: #(Int, Int)) {
      validate_ids(range.0, range.1)
    })

  list.fold(invalid_ranges, 0, fn(acc, id) { acc + id })
}
