def generate_lui_jalr_instructions(target_address, rd=1, rs1=1):
    """
    Generate the necessary LUI and JALR instructions to jump to a 32-bit address.
    
    :param target_address: The 32-bit target address.
    :param rd: The destination register (default is 1 for ra).
    :param rs1: The source register (default is 1 for ra).
    :return: A tuple of (LUI instruction, JALR instruction) in hex format.
    """
    # Generate the LUI instruction
    upper_20 = (target_address >> 12) & 0xfffff  # Extract the upper 20 bits (imm[31:12])
    lower_12 = target_address & 0xfff            # Extract the lower 12 bits (imm[11:0])

    # If lower_12 exceeds signed 12-bit range, adjust
    if lower_12 > 2047:
        upper_20 += 1
        lower_12 -= 4096  # Adjust lower to fit signed range

    # Construct the LUI instruction
    lui_instruction = ((upper_20 << 12) | (rd << 7) | 0x37) & 0xffffffff

    # Construct the JALR instruction
    jalr_instruction = ((lower_12 << 20) | (rs1 << 15) | (0x0 << 12) | (rd << 7) | 0x67) & 0xffffffff

    return f"LUI instruction: {lui_instruction:08x}", f"JALR instruction: {jalr_instruction:08x}"

# Example usage: an address in ROM
target_address = 0x40030d2c  # Example target address

lui_instr, jalr_instr = generate_lui_jalr_instructions(target_address)
print(lui_instr)
print(jalr_instr)

