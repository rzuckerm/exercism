use std::collections::HashSet;

// Euclid's formula:
//
// a = (m^2 - n^2)*k
// b = 2*m*n*k
// c = (m^2 + n^2)*k
//
// where:
// - k, m, and n are positive integers
// - m > n
// - a < b < c
pub fn find(sum: u32) -> HashSet<[u32; 3]> {
    let mut result = HashSet::<[u32; 3]>::new();
    for k in 1..=(sum / 12).max(1) { // Empirically determined
        let lower_bound = pythagorean_lower_bound(k, sum);
        let upper_bound = pythagorean_upper_bound(k, sum);
        for m in lower_bound..=upper_bound {
            if sum % (2 * k * m) == 0 {
                let n = sum / (2 * k * m) - m;
                let a = (m * m - n * n) * k;
                let b = 2 * m * n * k;
                result.insert([a.min(b), a.max(b), sum - a - b]);
            }
        }
    }

    result
}

// p = a + b + c
//   = (m^2 - n^2)*k + 2*m*n*k + (m^2 + n^2)*k
//   = 2*k*m^2 + 2*k*m*n
// p/(2*k) = m^2 + m*n
//         = m*(m + n)
// m + n = p/(2*k*m)
// n = p/(2*k*m) - m
// p must be divisible by 2*k*m
//
// n > 0:
//     p/(2*k*m) - m > 0
//     p/(2*k*m) > m
//     p/(2*k) > m^2
//     m < sqrt[p/(2*k)]
//
// n < m:
//     p/(2*k*m) - m < m
//     p/(2*k*m) < 2*m
//     p/(2*k) < 2*m^2
//     p/(4*k) < m^2
//     m > sqrt[p/(4*k)]
fn pythagorean_lower_bound(k: u32, sum: u32) -> u32 {
    let q = ((sum / (4 * k)) as f32).sqrt() as u32;
    (sum < 4 * k * q * q).then_some(q).unwrap_or(q + 1)
}

fn pythagorean_upper_bound(k: u32, sum: u32) -> u32 {
    let q = ((sum / (2 * k)) as f32).sqrt() as u32;
    (sum > 2 * k * q * q).then_some(q).unwrap_or(q - 1)
}
