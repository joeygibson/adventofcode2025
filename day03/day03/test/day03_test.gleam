import day03
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

  let res = day03.part1(lines)

  assert res == 357
}

pub fn part1_with_real_data_test() {
  let lines = get_data("../input1.txt")

  let res = day03.part1(lines)

  assert res == 17_158
}

pub fn part2_with_sample_test() {
  let lines = get_data("../input0.txt")

  let res = day03.part2(lines)

  assert res == 3_121_910_778_619
}

pub fn part2_with_real_data_test() {
  let lines = get_data("../input1.txt")

  let res = day03.part2(lines)

  assert res == 170_449_335_646_486
}
