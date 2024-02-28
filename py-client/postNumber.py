import requests

def post_numbers(numbers, addr, key):
    payload = {"numbers": numbers}  # Wrap the list in an object with a "numbers" key
    r = requests.post(addr + key, json=payload)
    if r.status_code != 200:
        print(r.status_code, r.text)