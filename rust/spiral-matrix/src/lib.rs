pub fn spiral_matrix(size: u32) -> Vec<Vec<u32>> {
    let mut position: (i32, i32) = (0, 0);
    let mut rotation: (i32, i32) = (0, 1);
    let mut count: (i32, i32) = (size as i32, size as i32);
    let mut offset: (i32, i32) = (0, 1);
    let mut matrix: Vec<Vec<u32>> = vec![vec![0; size as usize]; size as usize];
    for i in 1..=(size * size) {
        matrix[position.0 as usize][position.1 as usize] = i;
        count = (count.0 - offset.0, count.1 - offset.1);
        if count.0 == 0 || count.1 == 0 {
            rotation = (rotation.1, -rotation.0);
            offset = (offset.1, offset.0);
            count = (count.0 + count.1 - offset.0, count.0 + count.1 - offset.0);
        }

        position = (position.0 + rotation.0, position.1 + rotation.1);
    }

    matrix
}
