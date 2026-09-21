import time
from SmallScaleAES import SmallScaleAES

# Convert hex string → nibble list
def hex_to_nibbles(hex_string):
    return [int(c, 16) for c in hex_string]

plaintext = hex_to_nibbles("0000000000000000")

target_ciphertext = hex_to_nibbles("609B6227BA393803")

# Known last 40 bits
known_suffix = "BA9876543210"


# AES instance
AES = SmallScaleAES(
    rounds=10,
    rows=4,
    cols=4,
    wordSize=4
)



start = time.time()

for prefix in range(2**16):
    prefix_hex = f"{prefix:04X}"

    # full 64-bit key (16 nibbles)
    full_key = prefix_hex + known_suffix

    key = hex_to_nibbles(full_key)

    # encrypt
    AES.Encrypt(plaintext, key)

    result = AES.m_Data

    # compare
    if result == target_ciphertext:

        end = time.time()

        print("KEY FOUND")
        print("Recovered key =", full_key)
        print("Time =", end - start, "seconds")

        break

    # optional progress
    if prefix % 50 == 0:
        print("Checked", prefix)

else:
    print("Key not found")
