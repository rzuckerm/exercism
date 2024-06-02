def measure(bucket_one: int, bucket_two: int, goal: int, start_bucket: int) -> tuple[int, str, int]:
    capacities = [bucket_one, bucket_two] if start_bucket == "one" else [bucket_two, bucket_one]
    other_bucket = "two" if start_bucket == "one" else "one"

    # Starting bucket is full, other bucket is empty
    buckets = [capacities[0], 0]

    # Keep going until goal is met is with either bucket or too many moves
    for moves in range(1, 101):
        # Goal met with either bucket
        if goal in buckets:
            return (moves, start_bucket, buckets[1]) if buckets[0] == goal else (moves, other_bucket, buckets[0])

        # Fill other bucket if goal can be met with it
        if capacities[1] == goal:
            buckets[1] = goal
        # Empty other bucket if full
        elif buckets[1] == capacities[1]:
            buckets[1] = 0
        # Fill stack bucket if empty
        elif buckets[0] == 0:
            buckets[0] = capacities[0]
        # Otherwise, pour maximum amount from one bucket into the other
        else:
            buckets = [max(0, buckets[0] - capacities[1] + buckets[1]), min(buckets[1] + buckets[0], capacities[1])]

    raise ValueError("Solution could not be found")
