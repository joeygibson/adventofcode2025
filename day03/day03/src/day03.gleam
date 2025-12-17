import gleam/int
import gleam/list
import gleam/result
import gleam/string

fn parse_lines(lines: List(String)) -> List(List(Int)) {
  lines
  |> list.map(fn(line) {
    string.to_graphemes(line)
    |> list.map(fn(char) { int.parse(char) |> result.unwrap(0) })
  })
}

fn find_largest_in_range(bank: List(Int), start: Int, end: Int) -> #(Int, Int) {
  // Find the largest value and its position in the range [start, end]
  bank
  |> list.index_map(fn(val, idx) { #(val, idx) })
  |> list.filter(fn(pair) {
    let #(_val, idx) = pair
    idx >= start && idx <= end
  })
  |> list.fold(#(0, start), fn(best, current) {
    let #(best_val, _) = best
    let #(cur_val, cur_pos) = current
    case cur_val > best_val {
      True -> #(cur_val, cur_pos)
      False -> best
    }
  })
}

fn find_batteries_in_bank(needed: Int, bank: List(Int)) -> Int {
  let bank_size = list.length(bank)

  // Build up the list of digits
  let numbers =
    list.range(1, needed)
    |> list.fold(#([], 0), fn(acc, i) {
      let #(numbers, pos) = acc

      let start = pos
      let end = bank_size - 1 - { needed - i }

      let #(val, new_pos) = find_largest_in_range(bank, start, end)

      #(list.append(numbers, [val]), new_pos + 1)
    })

  // Join the numbers and convert to integer
  let #(final_numbers, _) = numbers
  final_numbers
  |> list.map(int.to_string)
  |> string.join("")
  |> int.parse
  |> result.unwrap(0)
}

fn find_batteries(needed: Int, banks: List(List(Int))) -> Int {
  banks
  |> list.map(fn(bank) { find_batteries_in_bank(needed, bank) })
  |> list.fold(0, fn(acc, val) { acc + val })
}

pub fn part1(lines: List(String)) -> Int {
  let banks = parse_lines(lines)

  find_batteries(2, banks)
}

pub fn part2(lines: List(String)) -> Int {
  let banks = parse_lines(lines)

  find_batteries(12, banks)
}
