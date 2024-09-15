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
    lui_opcode = 0x37  # LUI opcode

    # Construct the LUI instruction (upper_20 << 12) | (rd << 7) | lui_opcode
    lui_instruction = (upper_20 << 12) | (rd << 7) | lui_opcode

    # Generate the JALR instruction
    lower_12 = target_address & 0xfff  # Extract the lower 12 bits (imm[11:0])
    jalr_opcode = 0x67  # JALR opcode
    funct3 = 0x0  # funct3 for JALR is always 0

    # Construct the JALR instruction
    jalr_instruction = (lower_12 << 20) | (rs1 << 15) | (funct3 << 12) | (rd << 7) | jalr_opcode

    return f"LUI instruction: {lui_instruction:08x}", f"JALR instruction: {jalr_instruction:08x}"

# Example usage: an address in ROM
target_address = 0x400400c0  # Example target address

lui_instr, jalr_instr = generate_lui_jalr_instructions(target_address)
print(lui_instr)
print(jalr_instr)

