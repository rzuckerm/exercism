pub fn is_valid(code: &str) -> bool {
    let chars: Vec<char> = code.chars().filter(|&c| !c.is_whitespace()).collect();
    chars.len() >= 2
        && chars.iter().all(|&c| c >= '0' && c <= '9')
        && chars.iter().rev().enumerate().fold(0, |acc, (n, c)| {
            let val = (1 + n % 2) * c.to_digit(10).unwrap() as usize;
            (acc + val + val / 10) % 10
        }) == 0
}
