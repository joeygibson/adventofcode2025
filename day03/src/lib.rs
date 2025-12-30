mod aoc;

fn parse_lines(lines: Vec<String>) -> Vec<Vec<u8>> {
    lines
        .iter()
        .map(|line| {
            line.chars()
                .map(|c| c.to_digit(10).unwrap() as u8)
                .collect()
        })
        .collect()
}

fn find_batteries_in_bank(num: usize, banks: Vec<Vec<u8>>) -> Vec<u64> {
    banks
        .iter()
        .map(move |bank| {
            let mut numbers = vec![];
            let mut pos = 0;

            for i in 1..=num {
                let res = find_largest_in_range(&bank, pos, bank.len() - 1 - (num - i));
                let val = res.0;
                pos = res.1 + 1;
                numbers.push(val);
            }

            let res = numbers
                .iter()
                .map(move |n| n.to_string())
                .collect::<Vec<String>>()
                .join("");
            let num: u64 = res.parse().unwrap();

            num
        })
        .collect()
}

fn find_largest_in_range(bank: &Vec<u8>, start: usize, end: usize) -> (u8, usize) {
    let mut largest = 0;
    let mut largest_pos = start;

    for i in start..=end {
        if bank[i] > largest {
            largest = bank[i];
            largest_pos = i;
        }
    }

    (largest, largest_pos)
}

fn part1(lines: Vec<String>) -> u64 {
    let banks = parse_lines(lines);

    find_batteries_in_bank(2, banks).iter().sum()
}

fn part2(lines: Vec<String>) -> u64 {
    let banks = parse_lines(lines);

    find_batteries_in_bank(12, banks).iter().sum()
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::aoc::load_data;

    #[test]
    fn test_part_1_with_sample_data() {
        let lines = load_data("input0.txt");
        let result = part1(lines);
        assert_eq!(357, result);
    }

    #[test]
    fn test_part_1_with_real_data() {
        let lines = load_data("input1.txt");
        let result = part1(lines);
        assert_eq!(17158, result);
    }

    #[test]
    fn test_part_2_with_sample_data() {
        let lines = load_data("input0.txt");
        let result = part2(lines);
        assert_eq!(3121910778619, result);
    }

    #[test]
    fn test_part_2_with_real_data() {
        let lines = load_data("input1.txt");
        let result = part2(lines);
        assert_eq!(170449335646486, result);
    }
}
