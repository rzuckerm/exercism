use std::cmp::Ordering;
use std::collections::HashMap;

#[derive(Default, Clone, Copy)]
struct TeamStats {
    wins: u32,
    draws: u32,
    losses: u32,
}

fn get_score(stats: &TeamStats) -> u32 {
    3 * stats.wins + stats.draws
}

pub fn tally(match_results: &str) -> String {
    let mut stats_map: HashMap<String, TeamStats> = HashMap::new();
    for line in match_results.lines() {
        let v: Vec<&str> = line.splitn(3, ';').collect();
        let [name1, name2, outcome] = <[&str; 3]>::try_from(v).ok().unwrap();
        match outcome {
            "win" => {
                update_stat(&mut stats_map, name1, |stat| stat.wins += 1);
                update_stat(&mut stats_map, name2, |stat| stat.losses += 1);
            }
            "loss" => {
                update_stat(&mut stats_map, name1, |stat| stat.losses += 1);
                update_stat(&mut stats_map, name2, |stat| stat.wins += 1);
            }
            _ => {
                update_stat(&mut stats_map, name1, |stat| stat.draws += 1);
                update_stat(&mut stats_map, name2, |stat| stat.draws += 1);
            }
        }
    }

    let mut stats: Vec<(String, TeamStats)> = stats_map.into_iter().collect();
    stats.sort_by(
        |(name1, stat1), (name2, stat2)| match get_score(stat2).cmp(&get_score(stat1)) {
            Ordering::Equal => name1.cmp(name2),
            x => x,
        },
    );
    stats.iter().fold(
        format!(
            "{:30} | {:>2} | {:>2} | {:>2} | {:>2} | {:>2}",
            "Team", "MP", "W", "D", "L", "P"
        ),
        |acc, (name, stat)| {
            acc + &format!(
                "\n{:30} | {:>2} | {:>2} | {:>2} | {:>2} | {:>2}",
                name,
                stat.wins + stat.losses + stat.draws,
                stat.wins,
                stat.draws,
                stat.losses,
                get_score(stat)
            )
        },
    )
}

fn update_stat(stats_map: &mut HashMap<String, TeamStats>, name: &str, f: fn(&mut TeamStats)) {
    stats_map.entry(name.to_owned().to_string()).or_default();
    stats_map.entry(name.to_owned().to_string()).and_modify(f);
}
