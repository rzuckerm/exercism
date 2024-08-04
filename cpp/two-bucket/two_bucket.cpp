#include "two_bucket.h"

#include <algorithm>
#include <stdexcept>

namespace two_bucket {
measure_result measure(int bucket1_capacity, int bucket2_capacity, int target_volume, bucket_id start_bucket) {
    int capacities[]{bucket1_capacity, bucket2_capacity};
    bucket_id bucket_ids[]{bucket_id::one, bucket_id::two};
    if (start_bucket == bucket_id::two) {
        std::swap(capacities[0], capacities[1]);
        std::swap(bucket_ids[0], bucket_ids[1]);
    }

    // Starting bucket is full, other bucket is empty
    int buckets[]{capacities[0], 0};

    // Keep going until goal is met is with either bucket or too many moves
    for (int moves = 1; moves <= 100; moves++) {
        // Goal met with either bucket
        if (buckets[0] == target_volume || buckets[1] == target_volume) {
            int which_bucket{buckets[1] == target_volume};
            return {moves, bucket_ids[which_bucket], buckets[1 - which_bucket]};
        }

        if (capacities[1] == target_volume) {
            // Fill other bucket if goal can be met with it
            buckets[1] = target_volume;
        } else if (buckets[1] == capacities[1]) {
            // Empty other bucket if full
            buckets[1] = 0;
        } else if (buckets[0] == 0) {
            // Fill start bucket if empty
            buckets[0] = capacities[0];
        } else {
            // Otherwise, pour maximum amount from one bucket into the other
            int temp = std::max(0, buckets[0] - capacities[1] + buckets[1]);
            buckets[1] = std::min(buckets[1] + buckets[0], capacities[1]);
            buckets[0] = temp;
        }
    }

    throw std::invalid_argument("No solution");
}
}  // namespace two_bucket
