from collections import deque


def simulate_game(player_a, player_b):
    debts = tuple(deque("JQKA".find(card) + 1 for card in hand) for hand in (player_a, player_b))
    prior_states, pile, current_player, debt, cards_played, tricks, status = set(), [], 0, 0, 0, 0, "loop"

    while True:
        current_state = tuple(tuple(debt) for debt in debts)
        if current_state in prior_states:
            break

        if any(any(debt) for debt in debts):
            prior_states.add(current_state)

        while True:
            orig_debt = debt
            if not (current_debt := debts[current_player]):
                break

            pile.append(new_debt := current_debt.popleft())
            cards_played += 1

            if (debt := new_debt or max(debt - 1, 0)) == 0 and orig_debt > 0:
                break

            if new_debt > 0 or debt == 0:
                current_player = 1 - current_player

        current_player = 1 - current_player
        debts[current_player].extend(pile)
        pile = []
        tricks += 1
        if not pile and (not debts[0] or not debts[1]):
            status = "finished"
            break

    return {"status": status, "tricks": tricks, "cards": cards_played}
