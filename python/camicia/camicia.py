from collections import deque


def simulate_game(player_a, player_b):
    status = "loop"
    game_state = GameState(player_a, player_b)
    prior_states = set()

    while True:
        current_state = game_state.get_state()
        if current_state in prior_states:
            break

        if any(card in "JQKA" for hand in (player_a, player_b) for card in hand):
            prior_states.add(current_state)

        if game_state.play_turn_and_check_if_done():
            status = "finished"
            break

    return {"status": status, "tricks": game_state.tricks, "cards": game_state.cards_played}


class GameState:
    def __init__(self, player_a, player_b):
        self.hands = (deque(player_a), deque(player_b))
        self.pile = []
        self.current_player, self.debt, self.cards_played, self.tricks = 0, 0, 0, 0

    def get_state(self):
        return tuple(" ".join(card if card in "JQKA" else "-" for card in hand) for hand in self.hands)

    def play_turn_and_check_if_done(self):
        while True:
            orig_debt = self.debt
            current_hand = self.hands[self.current_player]
            if not current_hand:
                self.transfer_pile()
                break

            self.pile.append(top_card := current_hand.popleft())
            self.cards_played += 1

            if (new_debt := "JQKA".find(top_card) + 1) > 0:
                self.debt = new_debt
            else:
                self.debt = max(self.debt - 1, 0)
                if orig_debt > 0 and self.debt == 0:
                    self.transfer_pile()
                    self.next_player()
                    break

            if new_debt > 0 or self.debt == 0:
                self.next_player()

        return not self.pile and (not self.hands[0] or not self.hands[1])

    def next_player(self):
        self.current_player = 1 - self.current_player

    def transfer_pile(self):
        self.hands[1 - self.current_player].extend(self.pile)
        self.pile.clear()
        self.tricks += 1
