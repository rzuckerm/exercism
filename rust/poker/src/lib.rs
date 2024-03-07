use std::collections::HashMap;

const JACK: u8 = 11;
const QUEEN: u8 = 12;
const KING: u8 = 13;
const ACE: u8 = 14;

const ONE_OF_KIND_IDX: usize = 0;
const TWO_OF_KIND_IDX: usize = 1;
const THREE_OF_KIND_IDX: usize = 2;
const FOUR_OF_KIND_IDX: usize = 3;
const FIVE_OF_KIND_IDX: usize = 4;

#[derive(PartialEq, PartialOrd, Ord, Eq)]
struct Card {
    value: u8,
    suit: u8,
}

type Hand = Vec<Card>;

#[derive(PartialEq, PartialOrd, Ord, Eq)]
enum Rank {
    HighCard = 0,
    OnePair = 1,
    TwoPair = 2,
    ThreeOfKind = 3,
    Straight = 4,
    Flush = 5,
    FullHouse = 6,
    FourOfKind = 7,
    StraightFlush = 8,
    FiveOfKind = 9,
}

#[derive(PartialEq, PartialOrd, Ord, Eq)]
struct HandValue {
    rank: Rank,
    tie_breaker: Vec<u8>,
}

pub fn winning_hands<'a>(hands: &[&'a str]) -> Vec<&'a str> {
    let hands_vec: Vec<Hand> = hands.iter().map(|&hand| parse_hand(hand)).collect();
    let hand_values: Vec<HandValue> = hands_vec.iter().map(|hand| get_hand_value(hand)).collect();
    let best_hand_value: &HandValue = hand_values.iter().max().unwrap();
    Vec::from_iter(
        hand_values
            .iter()
            .enumerate()
            .filter(|&(_, hand_value)| hand_value == best_hand_value)
            .map(|(n, _)| hands[n])
            .collect::<Vec<&'a str>>(),
    )
}

fn parse_hand(s: &str) -> Hand {
    let mut hand: Hand = s.split_whitespace().map(parse_card).collect();
    hand.sort_unstable_by(|a, b| b.cmp(a));
    hand
}

fn parse_card(s: &str) -> Card {
    let (value_str, suit) = s.split_at(s.len() - 1);
    let value: u8 = match value_str {
        "A" => ACE,
        "J" => JACK,
        "Q" => QUEEN,
        "K" => KING,
        v => v.parse::<u8>().unwrap(),
    };

    Card {
        value: value,
        suit: suit.as_bytes()[0],
    }
}

fn get_hand_value(hand: &Hand) -> HandValue {
    let card_values: Vec<u8> = hand.iter().map(|card| card.value).collect();
    let rank: Rank;
    let tie_breaker: Vec<u8>;
    let card_dist = get_card_distribution(&card_values);
    if !card_dist[FIVE_OF_KIND_IDX].is_empty() {
        // 5-of-a-kind (possible with 2 decks): Use quintuplet as tie-breaker
        rank = Rank::FiveOfKind;
        tie_breaker = vec![card_values[0]];
    } else if !card_dist[FOUR_OF_KIND_IDX].is_empty() {
        // 4-of-a-kind: use quadruplet then kicker as tie-breaker
        rank = Rank::FourOfKind;
        tie_breaker = vec![
            card_dist[FOUR_OF_KIND_IDX][0],
            card_dist[ONE_OF_KIND_IDX][0],
        ]
    } else {
        let flush = hand[1..].iter().all(|card| card.suit == hand[0].suit);
        let ace_low_straight = card_values == vec![ACE, 5, 4, 3, 2];
        let high_card = if ace_low_straight { 5 } else { card_values[0] };
        let straight = card_values.windows(2).all(|w| w[0] == w[1] + 1);
        (rank, tie_breaker) = match (flush, straight || ace_low_straight) {
            // Straight flush: use high card as tie-breaker
            (true, true) => (Rank::StraightFlush, vec![high_card]),

            // Flush: use kickers from highest to lowest as tie-breaker
            (true, false) => (Rank::Flush, card_values.clone()),

            // Straight: use high card as tie-breaker
            (false, true) => (Rank::Straight, vec![high_card]),

            (false, false) => {
                // 3-of-a-kind, 2-of-a-kind
                match (
                    card_dist[THREE_OF_KIND_IDX].len(),
                    card_dist[TWO_OF_KIND_IDX].len(),
                ) {
                    // Full house: use triplet, then pair as tie-breaker
                    (1, 1) => (
                        Rank::FullHouse,
                        vec![
                            card_dist[THREE_OF_KIND_IDX][0],
                            card_dist[TWO_OF_KIND_IDX][0],
                        ],
                    ),

                    // 3-of-a-kind: use triplet, then high kicker, then low kicker as tie-breaker
                    (1, 0) => (
                        Rank::ThreeOfKind,
                        vec![
                            card_dist[THREE_OF_KIND_IDX][0],
                            card_dist[ONE_OF_KIND_IDX][0],
                            card_dist[ONE_OF_KIND_IDX][1],
                        ],
                    ),

                    // 2 pair: use high pair, then low pair, then kicker as tie-breaker
                    (0, 2) => (
                        Rank::TwoPair,
                        vec![
                            card_dist[TWO_OF_KIND_IDX][0],
                            card_dist[TWO_OF_KIND_IDX][1],
                            card_dist[ONE_OF_KIND_IDX][0],
                        ],
                    ),

                    // 1 pair: use pair, then remaining kickers from highest to lowest as tie-breaker
                    (0, 1) => (
                        Rank::OnePair,
                        vec![
                            card_dist[TWO_OF_KIND_IDX][0],
                            card_dist[ONE_OF_KIND_IDX][0],
                            card_dist[ONE_OF_KIND_IDX][1],
                            card_dist[ONE_OF_KIND_IDX][2],
                        ],
                    ),

                    // High card: Use kickers from highest to lowest as tie-breaker
                    (_, _) => (Rank::HighCard, card_values.clone()),
                }
            }
        }
    }

    HandValue {
        rank: rank,
        tie_breaker: tie_breaker,
    }
}

fn get_card_distribution(card_values: &Vec<u8>) -> Vec<Vec<u8>> {
    let dist_by_value = card_values
        .iter()
        .fold(HashMap::<u8, u8>::new(), |mut acc, &value| {
            *acc.entry(value).or_insert(0) += 1;
            acc
        });
    let mut dist_by_count: Vec<Vec<u8>> = vec![vec![]; card_values.len()];
    for (value, count) in dist_by_value {
        dist_by_count[count as usize - 1].push(value);
    }

    for count in 0..card_values.len() {
        dist_by_count[count].sort_unstable_by(|a, b| b.cmp(a));
    }

    dist_by_count
}
