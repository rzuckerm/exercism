use std::collections::BTreeMap;

type ChainKey = (usize, bool);

pub fn chain(input: &[(u8, u8)]) -> Option<Vec<(u8, u8)>> {
    match input.len() {
        0 => Some(vec![]),
        1 => (input[0].0 == input[0].1).then_some(vec![input[0]]),
        _ => {
            let chainables = get_chainables(input)?;
            for &key in chainables.keys() {
                let mut visited = vec![false; input.len()];
                let mut output = Vec::<(u8, u8)>::new();
                if let Some(chain) =
                    find_first_chain_for_key(key, input, &chainables, &mut visited, &mut output)
                {
                    return Some(chain);
                }
            }

            None
        }
    }
}

fn get_chainables(input: &[(u8, u8)]) -> Option<BTreeMap<ChainKey, Vec<ChainKey>>> {
    let mut chainables = BTreeMap::<ChainKey, Vec<ChainKey>>::new();
    for (i, &(first1, second1)) in input.iter().enumerate() {
        for (second, forward) in [(second1, true), (first1, false)] {
            for (j, &(first2, second2)) in input.iter().enumerate() {
                if i == j {
                    continue;
                }

                if second == first2 || second == second2 {
                    (*chainables.entry((i, forward)).or_default()).push((j, second == first2));
                }
            }

            chainables.get(&(i, forward))?;
        }
    }

    Some(chainables)
}

fn find_first_chain_for_key(
    key: ChainKey,
    input: &[(u8, u8)],
    chainables: &BTreeMap<ChainKey, Vec<ChainKey>>,
    visited: &mut Vec<bool>,
    output: &mut Vec<(u8, u8)>,
) -> Option<Vec<(u8, u8)>> {
    visited[key.0] = true;
    match key.1 {
        true => output.push(input[key.0]),
        false => output.push((input[key.0].1, input[key.0].0)),
    }

    if output.len() == input.len() {
        return (output[0].0 == output.last().unwrap().1).then_some(output.clone());
    }

    for &next_key in &chainables[&key] {
        if !visited[next_key.0] {
            if let Some(next_output) =
                find_first_chain_for_key(next_key, input, chainables, visited, output)
            {
                return Some(next_output);
            }
        }
    }

    visited[key.0] = false;
    output.pop();

    None
}
