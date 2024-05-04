ANSWERS = ["Whatever.", "Sure.", "Whoa, chill out!", "Calm down, I know what I'm doing!"]

def response(hey_bob):
    hey_bob = hey_bob.strip()
    if not hey_bob:
        return "Fine. Be that way!"

    return ANSWERS[hey_bob.isupper() * 2 + hey_bob.endswith("?")]
