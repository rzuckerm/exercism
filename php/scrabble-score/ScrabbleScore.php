<?php

declare(strict_types=1);

//              A  B  C  D  E  F  G  H  I  J  K  L  M  N  O  P  Q   R  S  T  U  V  W  X  Y  Z
const SCORES = [1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10];

function score(string $word): int
{
    return array_sum(array_map(fn(string $l): int => SCORES[ord($l) - ord("A")] ?? 0, str_split(strtoupper($word))));
}
