import time
from itertools import product

from SmallScaleAES import SmallScaleAES
from injection import SETS, solve_set, hex_to_nibbles

C = hex_to_nibbles("609B6227BA393803")
PLAINTEXT = hex_to_nibbles("0000000000000000")


def generate_last_round_key_candidates():
    """Yield every full 16-nibble final round key candidate."""
    set_solutions = [solve_set(s["positions"], s["coeffs"]) for s in SETS]

    for combination in product(*set_solutions):
        positions = []
        key_lists = []
        for set_data, entry in zip(SETS, combination):
            positions.extend(set_data["positions"])
            key_lists.extend(entry["keys"])

        for values in product(*key_lists):
            key = [None] * 16
            for pos, value in zip(positions, values):
                key[pos] = value
            yield key


def verify_candidate_last_round_key(last_round_key):
    """Return original key if the candidate last round key encrypts correctly."""
    aes = SmallScaleAES(rounds=10, rows=4, cols=4, wordSize=4)
    original_key = aes.ReverseKeySchedule(last_round_key.copy(), 9)

    plaintext = PLAINTEXT.copy()
    aes.Encrypt(plaintext, original_key)

    return plaintext == C, original_key


def recover_key():
    start = time.time()
    total_tested = 0

    for last_round_key in generate_last_round_key_candidates():
        total_tested += 1
        if total_tested % 100000 == 0:
            print(f"Tested {total_tested} candidates...")

        valid, original_key = verify_candidate_last_round_key(last_round_key)
        if valid:
            print("Found candidate:")
            print("  Final round key:", ''.join(f'{x:X}' for x in last_round_key))
            print("  Original key:", ''.join(f'{x:X}' for x in original_key))
            print("  Tested candidates:", total_tested)
            print("Elapsed time:", time.time() - start, "seconds")
            return original_key

    print("No valid key found.")
    print("Total tested:", total_tested)
    print("Elapsed time:", time.time() - start, "seconds")
    return None


if __name__ == "__main__":
    recover_key()
