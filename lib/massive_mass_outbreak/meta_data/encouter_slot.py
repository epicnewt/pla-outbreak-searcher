
from math import floor
from pip import main


enctbl_slots = [
    [100, 1, 10, 1],
    [100, 1],
    [100],
    [100, 1, 100, 1, 100, 1, 100, 1, 100, 1, 100, 1, 100, 1, 100, 1, 100, 1, 100, 1, 100, 1, 100, 1, 100, 1, 100, 1,
        100, 1, 100, 1, 100, 1, 100, 1, 100, 1, 100, 1, 100, 1, 100, 1, 100, 1, 100, 1, 100, 1, 100, 1, 100, 1, 100, 1],
    [100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100,
        100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100],
    [100, 1, 10, 10, 1, 1],
    [100, 100, 1, 1],
    [100, 100],
];

# 0xFD7720F353A4BBFF - 0xFD7720F353A4C000

for enctbl in enctbl_slots:
    encsum = 0
    enctbl_slot_sum = sum(enctbl)
    print(f"\"{enctbl}\" : [")

    for slot in enctbl:
        encsum += slot


        if encsum == enctbl_slot_sum:
            print("0xFFFFFFFFFFFFFFFF]");
            break;

        # fixed_rng.next() = (encsum) * (2**64) / enctbl_slot_sum 
        # fixed_rng.next() / (2**64) * enctbl_slot_sum = (encsum)
        slot_max = floor(encsum * (2**64) / enctbl_slot_sum)
        diff = 0

        limit = floor((slot_max + diff) / 2**64 * enctbl_slot_sum)

        while not (encsum > ((slot_max + diff) / 2**64 * enctbl_slot_sum)):
            # non_alpha = (fixed_rng.next()) < 100 * (2**64) / 101
            diff -= 1;
            # print(f"diff: {diff}     {((slot_max + diff) / 2**64 * enctbl_slot_sum)} vs {encsum}", end = "\r")
            pass

        if diff == 0:
            while (encsum > ((slot_max + diff) / 2**64 * enctbl_slot_sum)):
                # non_alpha = (fixed_rng.next()) < 100 * (2**64) / 101
                diff += 1;
                # print(f"diff: {diff}     {((slot_max + diff) / 2**64 * enctbl_slot_sum)} vs {encsum}", end = "\r")
                pass
            diff -= 1;

        print(f"0x{(slot_max + diff):X}", end = ", ");

        # print(f"Slot {slot} max {(slot_max + diff):X}", end = "");
        # print(f" :: encsum {encsum} > {(slot_max + diff) / 2**64 * enctbl_slot_sum} :: {encsum > ((slot_max + diff) / 2**64 * enctbl_slot_sum)} :: {diff}");
        

    

if __name__ == "main":
    pass
