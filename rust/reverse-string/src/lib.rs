use unicode_reverse::reverse_grapheme_clusters_in_place;

pub fn reverse(input: &str) -> String {
    let mut str_copy = input.to_string();
    reverse_grapheme_clusters_in_place(&mut str_copy);
    str_copy.to_string()
}
