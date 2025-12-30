use std::ops::RangeInclusive;

mod aoc;

fn parse_lines(lines: Vec<String>) -> Vec<RangeInclusive<u64>> {
    let line = lines.iter().nth(0).unwrap();

    line.split(",")
        .map(|r| {
            let (start, end) = r.split_once("-").unwrap();
            let start: u64 = start.parse().unwrap();
            let end: u64 = end.parse().unwrap();
            start..=end
        })
        .collect()
}

fn part1(lines: Vec<String>) -> u64 {
    let ranges = parse_lines(lines);

    let invalid_ids = ranges.into_iter().flat_map(|range| {
        range.filter(|i| {
            let i_s = i.to_string();

            if i_s.len() % 2 != 0 {
                false
            } else {
                let pivot = i_s.len() / 2;
                &i_s[0..pivot] == &i_s[pivot..i_s.len()]
            }
        })
    });

    invalid_ids.fold(0, |acc, i| acc + i)
}

fn validate_id(id: u64) -> bool {
    let id_s = id.to_string();
    let len = id_s.len();
    let pivot = len / 2;

    (1..=pivot).any(|i| {
        let sub = &id_s[0..i];
        let chunks = id_s.split(sub).collect::<Vec<&str>>();
        chunks.iter().all(|chunk| chunk.is_empty())
    })
}

fn part2(lines: Vec<String>) -> u64 {
    let ranges = parse_lines(lines);

    let invalid_ids = ranges
        .into_iter()
        .flat_map(|range| range.filter(|id| validate_id(*id)));

    invalid_ids.fold(0, |acc, i| acc + i)
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::aoc::load_data;

    #[test]
    fn test_part_1_with_sample_data() {
        let lines = load_data("input0.txt");
        let result = part1(lines);
        assert_eq!(1227775554, result);
    }

    #[test]
    fn test_part_1_with_real_data() {
        let lines = load_data("input1.txt");
        let result = part1(lines);
        assert_eq!(19219508902, result);
    }

    #[test]
    fn test_part_2_with_sample_data() {
        let lines = load_data("input0.txt");
        let result = part2(lines);
        assert_eq!(4174379265, result);
    }

    #[test]
    fn test_part_2_with_real_data() {
        let lines = load_data("input1.txt");
        let result = part2(lines);
        assert_eq!(27180728081, result);
    }
}
