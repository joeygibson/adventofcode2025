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

fn repeats_twice(id: Int) -> Bool {
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

fn repeats_at_least_twice(id: Int) -> Bool {
  let str = int.to_string(id)
  let size = string.length(str)

  // Only check pattern lengths that divide evenly into total length
  list.range(1, size / 2)
  |> list.any(fn(pattern_len) {
    case size % pattern_len {
      0 -> {
        // Get the pattern
        let pattern = string.slice(str, 0, pattern_len)
        // Check if the entire string is just this pattern repeated
        check_pattern_repeats(str, pattern, pattern_len, size)
      }
      _ -> False
    }
  })
}

fn check_pattern_repeats(
  str: String,
  pattern: String,
  pattern_len: Int,
  total_len: Int,
) -> Bool {
  let num_repeats = total_len / pattern_len

  // Must repeat at least twice
  case num_repeats >= 2 {
    True -> {
      list.range(1, num_repeats - 1)
      |> list.all(fn(i) {
        let offset = i * pattern_len
        string.slice(str, offset, pattern_len) == pattern
      })
    }
    False -> False
  }
}

fn validate_ids(start: Int, end: Int, validator: fn(Int) -> Bool) -> List(Int) {
  list.range(start, end + 1)
  |> list.filter(validator)
}

pub fn part1(lines: List(String)) -> Int {
  let ranges = parse(list.first(lines) |> result.unwrap(""))

  let invalid_ranges =
    list.flat_map(ranges, fn(range: #(Int, Int)) {
      validate_ids(range.0, range.1, repeats_twice)
    })

  list.fold(invalid_ranges, 0, fn(acc, id) { acc + id })
}

pub fn part2(lines: List(String)) -> Int {
  let ranges = parse(list.first(lines) |> result.unwrap(""))

  let invalid_ranges =
    list.flat_map(ranges, fn(range: #(Int, Int)) {
      validate_ids(range.0, range.1, repeats_at_least_twice)
    })

  list.fold(invalid_ranges, 0, fn(acc, id) { acc + id })
}
