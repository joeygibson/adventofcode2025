import day01
import simplifile

import gleam/result
import gleam/string
import gleeunit

pub fn main() -> Nil {
  gleeunit.main()
}

fn get_data(file_name: String) -> List(String) {
  simplifile.read(file_name)
  |> result.map(fn(contents) {
    contents
    |> string.trim
    |> string.split("\n")
  })
  |> result.unwrap([])
}

pub fn part1_with_sample_test() {
  let lines = get_data("../input0.txt")

  let res = day01.part1(lines)

  assert res == Ok(3)
}

pub fn part1_with_real_data_test() {
  let lines = get_data("../input1.txt")

  let res = day01.part1(lines)

  assert res == Ok(1031)
}
