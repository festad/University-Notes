# The address where the function
# execute_shellcode();
# defined as
# viod (*execute_shellcode)(void) = (void (*)(void));
#
# When the shellcode was 
# 0xef, 0x80, 0x72, 0x3f
# the address of &shellcode[0] was 0x40820c6c
#
# When the shellcode was
# 0xef, 0x80, 0x72, 0x3f,
# 0xef, 0x80, 0x72, 0x3f,
# the address of &shellcode[0] was 0x40820c68,
# exactly 4 bytes before the previous address.
# The base address of the shellcode is
# 0x40820c70 - length of the shellcode

current_address = 0x40820c6c
# Address of a random function,
# e.g. ic_create_wifi_task();
target_address  = 0x40849862

# Calculate the offset
offset = target_address - current_address
print(f"Offset in bytes: {offset:#x}")

# CAREFUL - THIS IS NOT THE CASE FOR THE ESP32C6 RISCV RV32IMC
# Divide by 2 (since the immediate is half the byte offset due to instruction alignment)
# immediate = offset // 2
immediate = offset
print(f"Immediate value: {immediate:#x}")

# Since we are working with a 20-bit signed value, we need to sign-extend it properly.
if immediate < 0:
    immediate &= 0xfffff
print(f"Sign-extended immediate value: {immediate:#x}")

# Extract each part from the immediate
imm20 = (immediate >> 19) & 0x1         # Bit 20
imm10_1 = (immediate >> 1) & 0x3ff      # Bits 10:1
imm11 = (immediate >> 11) & 0x1         # Bit 11
imm19_12 = (immediate >> 12) & 0xff     # Bits 19:12

# Display extracted fields
print(f"imm20 (sign bit): {imm20:#x}")
print(f"imm10_1 (bits 10:1): {imm10_1:#x}")
print(f"imm11 (bit 11): {imm11:#x}")
print(f"imm19_12 (bits 19:12): {imm19_12:#x}")

# Construct the final JAL instruction
# The JAL opcode (0x6f) and ra (1)
opcode = 0x6f
rd = 1

# Combine the fields into a 32-bit instruction
jal_instruction = (
    (imm20 << 31)        |  # Bit 20 at bit 31
    (imm19_12 << 12)     |  # Bits 19:12 at bits 12 to 19
    (imm11 << 20)        |  # Bit 11 at bit 20
    (imm10_1 << 21)      |  # Bits 10:1 at bits 21 to 30
    (rd << 7)            |  # Destination register at bits 7 to 11
    opcode               # Opcode at bits 0 to 6
)

# Output the instruction in hexadecimal
print(f"JAL instruction: {jal_instruction:08x}")

# Output the instruction in binary
print(f"JAL instruction (binary): {jal_instruction:032b}")

