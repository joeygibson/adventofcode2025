import gleam/dict.{type Dict}
import gleam/list
import gleam/string

fn parse_to_dict_grid(lines: List(String)) -> Dict(#(Int, Int), String) {
  lines
  |> list.index_map(fn(line, row) {
    line
    |> string.trim
    |> string.to_graphemes()
    |> list.index_map(fn(char, col) { #(#(col, row), char) })
  })
  |> list.flatten
  |> dict.from_list
}

fn get_eight_neighbors(
  grid: Dict(#(Int, Int), String),
  pos: #(Int, Int),
) -> List(String) {
  let deltas = [
    #(-1, -1),
    #(0, -1),
    #(1, -1),
    // top row
    #(-1, 0),
    #(1, 0),
    // middle row (left & right)
    #(-1, 1),
    #(0, 1),
    #(1, 1),
    // bottom row
  ]

  deltas
  |> list.filter_map(fn(delta) {
    let col = pos.0 + delta.0
    let row = pos.1 + delta.1
    grid
    |> dict.get(#(col, row))
  })
}

fn find_removable_rolls(
  grid: Dict(#(Int, Int), String),
  rolls: List(#(Int, Int)),
) -> List(#(Int, Int)) {
  rolls
  |> list.filter(fn(roll_pos) {
    let neighbors =
      get_eight_neighbors(grid, roll_pos)
      |> list.filter(fn(neighbor) { neighbor == "@" })
    neighbors |> list.length() < 4
  })
}

fn remove_rolls(
  grid: Dict(#(Int, Int), String),
  rolls_to_remove: List(#(Int, Int)),
) -> Dict(#(Int, Int), String) {
  list.fold(rolls_to_remove, grid, fn(acc_grid, roll_pos) {
    dict.insert(acc_grid, roll_pos, ".")
  })
}

pub fn part1(lines: List(String)) -> Int {
  let grid = parse_to_dict_grid(lines)

  let rolls =
    grid
    |> dict.filter(fn(_pos, value) { value == "@" })
    |> dict.to_list
    |> list.map(fn(entry) { entry.0 })

  let removable_rolls = find_removable_rolls(grid, rolls)

  removable_rolls |> list.length()
}

pub fn part2(lines: List(String)) -> Int {
  let grid = parse_to_dict_grid(lines)

  part2_loop(grid, 0)
}

fn part2_loop(grid: Dict(#(Int, Int), String), removed_count: Int) -> Int {
  let rolls =
    grid
    |> dict.filter(fn(_pos, value) { value == "@" })
    |> dict.to_list
    |> list.map(fn(entry) { entry.0 })

  let removable_rolls = find_removable_rolls(grid, rolls)

  case removable_rolls {
    [] -> removed_count
    _ -> {
      let new_removed_count = removed_count + list.length(removable_rolls)
      let new_grid = remove_rolls(grid, removable_rolls)
      part2_loop(new_grid, new_removed_count)
    }
  }
}
