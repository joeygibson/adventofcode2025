mod aoc;

fn parse_lines(lines: Vec<String>) -> Vec<(char, u64)> {
    lines
        .iter()
        .map(|line| {
            let dir = line.chars().nth(0).unwrap();

            let value: u64 = line
                .chars()
                .skip(1)
                .collect::<String>()
                .parse()
                .expect("invalid integer");
            (dir, value)
        })
        .collect()
}

fn part1(lines: Vec<String>) -> u64 {
    let instructions = parse_lines(lines);

    let res = instructions
        .iter()
        .fold((50i64, 0i64), |acc, (dir, clicks)| {
            let steps = (clicks % 100) as i64;

            let tmp = acc.0
                + match dir {
                    'L' => -steps,
                    'R' => steps,
                    _ => 0,
                };

            let tmp = if tmp < 0 {
                tmp + 100
            } else if tmp > 99 {
                tmp - 100
            } else {
                tmp
            };

            let zeros = if tmp == 0 { acc.1 + 1 } else { acc.1 };

            (tmp, zeros)
        });

    res.1 as u64
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::aoc::load_data;

    #[test]
    fn test_part_1_with_sample_data() {
        let lines = load_data("input0.txt");
        let result = part1(lines);
        assert_eq!(3, result);
    }

    #[test]
    fn test_part_1_with_real_data() {
        let lines = load_data("input1.txt");
        let result = part1(lines);
        assert_eq!(1031, result);
    }
}
