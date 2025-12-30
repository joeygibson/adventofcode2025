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
    23
}

fn part2(lines: Vec<String>) -> u64 {
    23
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::aoc::load_data;

    #[test]
    fn test_part_1_with_sample_data() {
        let lines = load_data("input0.txt");
        let result = part1(lines);
        assert_eq!(999, result);
    }

    #[test]
    fn test_part_1_with_real_data() {
        let lines = load_data("input1.txt");
        let result = part1(lines);
        assert_eq!(999, result);
    }

    #[test]
    fn test_part_2_with_sample_data() {
        let lines = load_data("input0.txt");
        let result = part2(lines);
        assert_eq!(999, result);
    }

    #[test]
    fn test_part_2_with_real_data() {
        let lines = load_data("input1.txt");
        let result = part2(lines);
        assert_eq!(999, result);
    }
}
