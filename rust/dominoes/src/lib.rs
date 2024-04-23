use std::collections::{BTreeMap, HashSet};

type ChainKey = (usize, bool);

pub fn chain(input: &[(u8, u8)]) -> Option<Vec<(u8, u8)>> {
    match input.len() {
        0 => Some(vec![]),
        1 => (input[0].0 == input[0].1).then_some(vec![input[0]]),
        _ => {
            let chainables = get_chainables(input)?;
            find_first_chain(input, &chainables)
        }
    }
}

fn get_chainables(input: &[(u8, u8)]) -> Option<BTreeMap<ChainKey, Vec<ChainKey>>> {
    let mut chainables = BTreeMap::<ChainKey, Vec<ChainKey>>::new();
    for (i, &(first1, second1)) in input.iter().enumerate() {
        let (mut first, mut second, mut forward) = (first1, second1, true);
        loop {
            for (j, &(first2, second2)) in input.iter().enumerate() {
                if i == j {
                    continue;
                }

                if second == first2 || second == second2 {
                    (*chainables.entry((i, forward)).or_default()).push((j, second == first2));
                }
            }

            chainables.get(&(i, forward))?;
            (first, second, forward) = (second, first, !forward);
            if first == first1 {
                break;
            }
        }
    }

    Some(chainables)
}

#[derive(Debug, Default)]
struct ChainMemory {
    visited: HashSet<usize>,
    keys: Vec<ChainKey>,
    results: Vec<(u8, u8)>,
}

fn find_first_chain(
    input: &[(u8, u8)],
    chainables: &BTreeMap<ChainKey, Vec<ChainKey>>,
) -> Option<Vec<(u8, u8)>> {
    for &key in chainables.keys() {
        let mut memory = ChainMemory::default();
        if let Some(chain) = find_first_chain_for_key(key, input, chainables, &mut memory) {
            return Some(chain);
        }
    }

    None
}

fn find_first_chain_for_key(
    key: ChainKey,
    input: &[(u8, u8)],
    chainables: &BTreeMap<ChainKey, Vec<ChainKey>>,
    memory: &mut ChainMemory,
) -> Option<Vec<(u8, u8)>> {
    memory.visited.insert(key.0);
    memory.keys.push(key);
    match key.1 {
        true => memory.results.push(input[key.0]),
        false => memory.results.push((input[key.0].1, input[key.0].0)),
    }

    if memory.results.len() == input.len() {
        return (memory.results[0].0 == memory.results.last().unwrap().1)
            .then_some(memory.results.clone());
    }

    for &next_key in &chainables[&key] {
        if !memory.visited.contains(&next_key.0) {
            if let Some(next_chain) = find_first_chain_for_key(next_key, input, chainables, memory)
            {
                return Some(next_chain);
            }
        }
    }

    memory.visited.remove(&key.0);
    memory.keys.pop();
    memory.results.pop();

    None
}
