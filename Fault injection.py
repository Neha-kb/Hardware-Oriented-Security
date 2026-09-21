import time
import InverseSBOX

SBOX_INV = InverseSBOX.InverseSBOX(4)


def hex_to_nibbles(h):
    return [int(c, 16) for c in h]


C  = hex_to_nibbles("609B6227BA393803")
Cf = hex_to_nibbles("A541E1B00210CA44")


def gf4_mul(a, b):
    p = 0

    for _ in range(4):

        if b & 1:
            p ^= a

        carry = a & 0x8

        a = (a << 1) & 0xF

        if carry:
            a ^= 0x3

        b >>= 1

    return p & 0xF

##Compute inverse S-box differences

def diff(index, key):
    return (
        SBOX_INV[C[index] ^ key]
        ^
        SBOX_INV[Cf[index] ^ key]
    )


#
# DFA sets 
#
SETS = [

    # Set 1
    {
        "positions": [0, 13, 10, 7],   # 1,14,11,8
        "coeffs":    [2, 1, 1, 3]
    },

    # Set 2
    {
        "positions": [4, 1, 14, 11],   # 5,2,15,12
        "coeffs":    [1, 1, 3, 2]
    },

    # Set 3
    {
        "positions": [8, 5, 2, 15],    # 9,6,3,16
        "coeffs":    [1, 3, 2, 1]
    },

    # Set 4
    {
        "positions": [12, 9, 6, 3],    # 13,10,7,4
        "coeffs":    [3, 2, 1, 1]
    }
]

## Try every possible fault value

def solve_set(positions, coeffs):

    solutions = []

    for delta in range(16):

        candidate_lists = []

        valid = True

        for pos, coeff in zip(positions, coeffs):

            target = gf4_mul(coeff, delta)

            keys = []

            for k in range(16):

                if diff(pos, k) == target:
                    keys.append(k)

            if len(keys) == 0:
                valid = False
                break

            candidate_lists.append(keys)

        if valid:

            solutions.append({
                "delta": delta,
                "keys": candidate_lists
            })

    return solutions


start = time.time()

all_results = []

for idx, s in enumerate(SETS):

    print()
    #print("=" * 50)
    print(f"SET {idx+1}")
    #print("=" * 50)

    result = solve_set(
        s["positions"],
        s["coeffs"]
    )

    all_results.append(result)

#    print("Solutions found:", len(result))

    for r in result[:10]:
        print(r)

print()
print("Finished in", time.time() - start, "seconds")
