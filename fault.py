from SmallScaleAES import SmallScaleAES

def hex_to_nibbles(s):
    return [int(c,16) for c in s]

plaintext = hex_to_nibbles("0000000000000000")
key = hex_to_nibbles("FEDCBA9876543210")

fault = [
    0x1,0,0,0,
    0,0,0,0,
    0,0,0,0,
    0,0,0,0
]

AES = SmallScaleAES(rounds=10,rows=4,cols=4,wordSize=4)

AES.EncryptWithFault(plaintext,key,targetRound=8,fault=fault)

print("Faulty ciphertext:")
print(''.join(f'{x:X}' for x in AES.m_Data))
