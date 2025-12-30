use std::fs;

#[allow(dead_code)]
pub fn load_data(file_name: &str) -> Vec<String> {
    let contents = fs::read_to_string(&file_name);

    contents
        .unwrap()
        .trim()
        .split('\n')
        .map(|s| s.to_string())
        .collect()
}

#[allow(dead_code)]
pub fn load_data_in_sections(file_name: &str) -> Vec<Vec<String>> {
    let lines = load_data(file_name);
    let mut sections: Vec<Vec<String>> = Vec::new();
    let mut current: Vec<String> = Vec::new();

    for line in lines.iter() {
        if line.trim().is_empty() {
            if !current.is_empty() {
                sections.push(current);
                current = Vec::new();
            }
        } else {
            current.push(line.to_string());
        }
    }

    if !current.is_empty() {
        sections.push(current);
    }

    sections
}

#[allow(dead_code)]
pub fn print_result(part: &str, result: u64) {
    println!("{part}: {result}");
}
