def create_lui_addi(imm_32bit, register):
    upper_20 = (imm_32bit >> 12) & 0xfffff  # Get upper 20 bits
    lower_12 = imm_32bit & 0xfff            # Get lower 12 bits

    # If lower_12 exceeds signed 12-bit range, adjust
    if lower_12 > 2047:
        upper_20 += 1
        lower_12 -= 4096 # Adjust lower to fit signed range

    # Create the LUI instruction
    lui_opcode = 0x37
    lui_instruction = ((upper_20 << 12) 
                       | (register << 7) 
                       | lui_opcode) & 0xffffffff 


    # Create the ADDI instruction (adds the lower 12 bits to the value in the register)
    addi_opcode = 0x13
    addi_instruction = ((lower_12 << 20) 
                        | (register << 15) 
                        | (0 << 12) 
                        | (register << 7) 
                        | addi_opcode) & 0xffffffff

    # return lui_instruction, addi_instruction
    return f"LUI instruction: {lui_instruction:08x}", f"ADDI instruction: {addi_instruction:08x}"

# Example usage
target_address = 0x400007fe
register = 10
lui_instruction, addi_instruction = create_lui_addi(target_address, register)
print(lui_instruction)
print(addi_instruction)
