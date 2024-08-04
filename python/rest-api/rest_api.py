import json


class RestAPI:
    def __init__(self, database: dict | None = None):
        self.database = {entry["name"]: entry for entry in (database or {}).get("users", [])}

    def get(self, url: str, payload: dict | None = None) -> str:
        payload, response = json.loads(payload or "{}"), {}
        if url == "/users":
            users = payload.get("users", []) or list(self.database)
            response = {"users": [self.database[x] for x in sorted(users) if x in self.database]}

        return json.dumps(response)

    def post(self, url: str, payload: dict | None = None) -> str:
        payload, response = json.loads(payload or "{}"), {}
        if url == "/add":
            response = {"name": payload["user"], "owes": {}, "owed_by": {}, "balance": 0.0}
            self.database[payload["user"]] = response
        elif url == "/iou":
            lender, borrower, amount = (payload[key] for key in ["lender", "borrower", "amount"])
            self._adjust_users(lender, borrower, amount)
            self._adjust_users(borrower, lender, -amount)
            response = {"users": [self.database[name] for name in sorted([lender, borrower])]}

        return json.dumps(response)

    def _adjust_users(self, name1: str, name2: str, amount: float):
        self.database[name1]["balance"] += amount
        diff = self.database[name1]["owed_by"].pop(name2, 0.0) - self.database[name1]["owes"].pop(name2, 0.0) + amount
        if diff > 0:
            self.database[name1]["owed_by"][name2] = diff
        elif diff < 0:
            self.database[name1]["owes"][name2] = -diff
