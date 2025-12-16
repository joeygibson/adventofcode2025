import day01
import simplifile

import gleam/result
import gleam/string
import gleeunit

pub fn main() -> Nil {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn part1_with_sample_test() {
  let lines =
    simplifile.read("../input0.txt")
    |> result.map(fn(contents) {
      contents
      |> string.trim
      |> string.split("\n")
    })
    |> result.unwrap([])

  let res = day01.part1(lines)

  assert res == Ok(3)
}
