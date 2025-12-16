import gleam/int
import gleam/list
import gleam/result
import gleam/string

type Turn {
  Turn(direction: String, steps: Int)
}

fn parse_lines(lines: List(String)) -> List(Turn) {
  list.map(lines, fn(line) {
    let direction = string.first(line) |> result.unwrap("")
    let steps = int.parse(string.drop_start(line, 1)) |> result.unwrap(0)

    Turn(direction: direction, steps: steps)
  })
}

fn normalize_steps(steps: Int) -> Int {
  steps % 100
}

pub fn part1(lines: List(String)) -> Result(Int, String) {
  let instructions = parse_lines(lines)

  let res =
    list.fold(over: instructions, from: #(50, 0), with: fn(acc, turn) {
      let dir = turn.direction
      let steps = normalize_steps(turn.steps)

      let tmp =
        acc.0
        + case dir {
          "L" -> -steps
          "R" -> steps
          _ -> 0
        }

      let tmp = case tmp {
        t if t < 0 -> t + 100
        t if t > 99 -> t - 100
        t -> t
      }

      let zeros = case tmp {
        0 -> acc.1 + 1
        _ -> acc.1
      }

      #(tmp, zeros)
    })
  Ok(res.1)
}

pub fn part2(lines: List(String)) -> Int {
  let instructions = parse_lines(lines)

  let #(zeros, _current) =
    list.fold(over: instructions, from: #(0, 50), with: fn(acc, instruction) {
      let Turn(dir, steps) = instruction
      let #(zeros, current) = acc

      let round_trips = steps / 100
      let remaining_steps = steps % 100
      let zeros = zeros + round_trips

      let remaining_steps = case dir {
        "L" -> -remaining_steps
        "R" -> remaining_steps
        _ -> 0
      }

      let tmp0 = current + remaining_steps

      let tmp1 = case tmp0 {
        t if t < 0 -> t + 100
        t if t > 99 -> t - 100
        t -> t
      }

      let zeros = case tmp0 {
        t if t < 0 ->
          case current {
            0 -> zeros
            _ -> zeros + 1
          }

        t if t > 99 ->
          case current {
            0 -> zeros
            _ -> zeros + 1
          }

        _ ->
          case tmp1 {
            0 -> zeros + 1
            _ -> zeros
          }
      }

      #(zeros, tmp1)
    })

  zeros
}
