<?php

declare(strict_types=1);

function wordCount(string $words): array
{
    return array_count_values(str_word_count(strtolower($words), 1, "0123456789"));
}
