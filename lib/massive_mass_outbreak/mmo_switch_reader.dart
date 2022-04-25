
void readMMOPointers() {

}

// def get_group_seed(reader,group_id,mapcount):
//     group_seed = reader.read_pointer_int(f"[[[[[[main+42BA6B0]+2B0]+58]+18]+" \
//                                          f"{0x1d4+group_id*0x90 + 0xb80 * mapcount+0x44:X}",8)
//     return group_seed

// def get_max_spawns(reader,group_id,maps,isbonus):
//     if isbonus:
//         max_spawns = reader.read_pointer_int(f"[[[[[[main+42BA6B0]+2B0]+58]+18]+" \
//                                              f"{0x1d4+group_id*0x90 + 0xb80 * maps+0x60:X}",4)
//     else:
//         max_spawns = reader.read_pointer_int(f"[[[[[[main+42BA6B0]+2B0]+58]+18]+" \
//                                              f"{0x1d4+group_id*0x90 + 0xb80 * maps+0x4c:X}",4)

//     return max_spawns
void groupSeed({required BigInt groupId}) {

// def get_gen_seed_to_group_seed(reader,group_id):

//     gen_seed = reader.read_pointer_int(f"[[[[[[main+42EEEE8]+78]+" \
//                                        f"{0xD48 + group_id*0x8:X}]+58]+38]+478]+20",8)
//     group_seed = (gen_seed - 0x82A2B175229D6A5B) & 0xFFFFFFFFFFFFFFFF

//     return group_seed
}

void readEncounterTable({required bool isBonusRound, required BigInt groupId}) {
    // if bonus:
    //     enc_pointer = reader.read_pointer_int(f"[[[[[[main+42BA6B0]+2B0]+58]+18]+" \
    //                                           f"{0x1d4+group_id*0x90 + 0xb80 * mapcount+0x2c:X}",8)
    // else:
    //     enc_pointer = reader.read_pointer_int(f"[[[[[[main+42BA6B0]+2B0]+58]+18]+" \
    //                                           f"{0x1d4+group_id*0x90 + 0xb80 * mapcount+0x24:X}",8)
}