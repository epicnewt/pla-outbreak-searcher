
const MALE_ONLY = 0;
const FEMALE_ONLY = ((32 * 8) - 1);
const GENDERLESS = -1;

const appearsInMassOutbreaks = [25, 41, 42, 46, 47, 54, 55, 63, 64, 77, 78, 113, 122, 123, 129, 130, 133, 172, 211, 234, 265, 266, 267, 268, 269, 390, 391, 396, 397, 398, 399, 400, 401, 402, 403, 404, 405, 415, 418, 419, 420, 422, 423, 427, 439, 440, 46, 47, 54, 55, 74, 75, 92, 93, 108, 111, 112, 113, 114, 175, 185, 193, 198, 216, 217, 315, 339, 340, 387, 388, 401, 402, 406, 415, 417, 434, 435, 438, 440, 449, 450, 453, 454, 455, 463, 465, 469, 548, 704, 705, 37, 58, 66, 67, 72, 73, 113, 114, 126, 175, 190, 211, 223, 224, 226, 240, 355, 356, 363, 364, 365, 393, 394, 396, 397, 398, 418, 419, 422, 423, 424, 425, 426, 431, 432, 440, 441, 451, 452, 456, 457, 458, 465, 550, 35, 41, 42, 74, 75, 95, 100, 111, 112, 113, 123, 125, 129, 130, 173, 185, 193, 200, 207, 214, 215, 216, 217, 239, 299, 315, 358, 403, 404, 405, 406, 433, 434, 435, 436, 437, 438, 440, 443, 444, 449, 450, 453, 454, 469, 479, 704, 705, 66, 67, 92, 93, 108, 113, 133, 190, 200, 207, 215, 220, 221, 234, 280, 281, 282, 355, 356, 358, 361, 362, 399, 400, 424, 425, 426, 433, 436, 437, 440, 443, 444, 446, 447, 459, 460, 473, 550, 570, 571, 627, 628, 712, 713];
const appearsInMassiveMassOutbreaks = [25, 26, 41, 42, 46, 47, 63, 64, 65, 74, 75, 76, 77, 78, 122, 123, 143, 169, 172, 234, 265, 266, 267, 268, 269, 363, 364, 390, 391, 392, 396, 397, 398, 399, 400, 401, 402, 403, 404, 405, 418, 419, 422, 423, 425, 426, 427, 428, 439, 441, 446, 570, 571, 899, 900, 46, 47, 54, 55, 92, 93, 94, 95, 108, 111, 112, 114, 155, 156, 157, 185, 193, 198, 201, 208, 216, 217, 220, 221, 315, 387, 388, 389, 401, 402, 406, 407, 417, 430, 434, 435, 436, 437, 438, 442, 449, 450, 451, 452, 453, 454, 455, 463, 464, 465, 469, 548, 549, 704, 705, 706, 901, 35, 37, 38, 54, 55, 58, 59, 66, 67, 68, 72, 73, 74, 75, 76, 95, 113, 126, 129, 130, 173, 175, 176, 190, 208, 211, 226, 240, 242, 363, 364, 365, 393, 394, 395, 396, 397, 398, 422, 423, 424, 431, 432, 440, 441, 447, 448, 451, 452, 456, 457, 458, 467, 468, 550, 902, 904, 35, 36, 74, 75, 76, 77, 78, 92, 93, 94, 100, 101, 111, 112, 122, 125, 173, 193, 200, 207, 214, 215, 239, 299, 355, 356, 358, 403, 404, 405, 429, 433, 434, 435, 436, 437, 439, 443, 444, 445, 449, 450, 459, 460, 464, 466, 469, 472, 476, 477, 479, 722, 723, 724, 903, 37, 38, 63, 64, 65, 66, 67, 68, 92, 93, 94, 108, 126, 190, 200, 220, 221, 240, 280, 281, 282, 355, 356, 361, 362, 399, 400, 417, 424, 425, 426, 427, 428, 429, 431, 432, 436, 437, 447, 448, 459, 460, 463, 473, 475, 477, 478, 501, 502, 503, 570, 571, 627, 628, 712, 713];

class PokedexEntry {
    final String pokemon;
    final int nationalDexNumber;
    final int genderRatio;

    bool isGenderFixed() {
        return genderRatio == MALE_ONLY || genderRatio == FEMALE_ONLY || genderRatio == GENDERLESS;
    }

    PokedexEntry(this.pokemon, this.nationalDexNumber, this.genderRatio);
}

Map<int, PokedexEntry> pokedex = {
    722: PokedexEntry('Rowlet', 722, 127), 723: PokedexEntry('Dartrix', 723, 127),
    155: PokedexEntry('Cyndaquil', 155, 127), 156: PokedexEntry('Quilava', 156, 127),
    501: PokedexEntry('Oshawott', 501, 127), 502: PokedexEntry('Dewott', 502, 127),
    399: PokedexEntry('Bidoof', 399, 127), 400: PokedexEntry('Bibarel', 400, 127),
    396: PokedexEntry('Starly', 396, 127), 397: PokedexEntry('Staravia', 397, 127), 398: PokedexEntry('Staraptor', 398, 127),
    403: PokedexEntry('Shinx', 403, 127), 404: PokedexEntry('Luxio', 404, 127), 405: PokedexEntry('Luxray', 405, 127),
    265: PokedexEntry('Wurmple', 265, 127), 266: PokedexEntry('Silcoon', 266, 127), 267: PokedexEntry('Beautifly', 267, 127),
    268: PokedexEntry('Cascoon', 268, 127), 269: PokedexEntry('Dustox', 269, 127),
    77: PokedexEntry('Ponyta', 77, 127), 78: PokedexEntry('Rapidash', 78, 127),
    133: PokedexEntry('Eevee', 133, 31),
    41: PokedexEntry('Zubat', 41, 127), 42: PokedexEntry('Golbat', 42, 127), 169: PokedexEntry('Crobat', 169, 127),
    425: PokedexEntry('Drifloon', 425, 127), 426: PokedexEntry('Drifblim', 426, 127),
    401: PokedexEntry('Kricketot', 401, 127), 402: PokedexEntry('Kricketune', 402, 127),
    418: PokedexEntry('Buizel', 418, 127), 419: PokedexEntry('Floatzel', 419, 127),
    74: PokedexEntry('Geodude', 74, 127), 75: PokedexEntry('Graveler', 75, 127), 76: PokedexEntry('Golem', 76, 127),
    234: PokedexEntry('Stantler', 234, 127), 899: PokedexEntry('Wyrdeer', 899, 127),
    446: PokedexEntry('Munchlax', 446, 31), 143: PokedexEntry('Snorlax', 143, 31),
    46: PokedexEntry('Paras', 46, 127), 47: PokedexEntry('Parasect', 47, 127),
    172: PokedexEntry('Pichu', 172, 127), 25: PokedexEntry('Pikachu', 25, 127), 26: PokedexEntry('Raichu', 26, 127),
    63: PokedexEntry('Abra', 63, 63), 64: PokedexEntry('Kadabra', 64, 63), 65: PokedexEntry('Alakazam', 65, 127),
    390: PokedexEntry('Chimchar', 390, 31), 391: PokedexEntry('Monferno', 391, 31), 392: PokedexEntry('Infernape', 392, 127),
    427: PokedexEntry('Buneary', 427, 127), 428: PokedexEntry('Lopunny', 428, 127),
    420: PokedexEntry('Cherubi', 420, 127),
    54: PokedexEntry('Psyduck', 54, 127), 55: PokedexEntry('Golduck', 55, 127),
    415: PokedexEntry('Combee', 415, 31),
    123: PokedexEntry('Scyther', 123, 127), 900: PokedexEntry('Kleavor', 900, 127),
    214: PokedexEntry('Heracross', 214, 127),
    439: PokedexEntry('Mime Jr.', 439, 127), 122: PokedexEntry('Mr. Mime', 122, 127),
    190: PokedexEntry('Aipom', 190, 127), 424: PokedexEntry('Ambipom', 424, 127),
    129: PokedexEntry('Magikarp', 129, 127), 130: PokedexEntry('Gyarados', 130, 127),
    422: PokedexEntry('Shellos', 422, 127), 423: PokedexEntry('Gastrodon', 423, 127),
    211: PokedexEntry('Qwilfish', 211, 127), 904: PokedexEntry('Overqwil', 904, 127),
    440: PokedexEntry('Happiny', 440, FEMALE_ONLY), 113: PokedexEntry('Chansey', 113, FEMALE_ONLY), 242: PokedexEntry('Blissey', 242, FEMALE_ONLY),
    406: PokedexEntry('Budew', 406, 127), 315: PokedexEntry('Roselia', 315, 127), 407: PokedexEntry('Roserade', 407, 127),
    455: PokedexEntry('Carnivine', 455, 127),
    548: PokedexEntry('Petilil', 548, FEMALE_ONLY), 549: PokedexEntry('Lilligant', 549, FEMALE_ONLY),
    114: PokedexEntry('Tangela', 114, 127), 465: PokedexEntry('Tangrowth', 465, 127),
    339: PokedexEntry('Barboach', 339, 127), 340: PokedexEntry('Whiscash', 340, 127),
    453: PokedexEntry('Croagunk', 453, 127), 454: PokedexEntry('Toxicroak', 454, 127),
    280: PokedexEntry('Ralts', 280, 127), 281: PokedexEntry('Kirlia', 281, 127), 282: PokedexEntry('Gardevoir', 282, 127), 475: PokedexEntry('Gallade', 475, 127),
    193: PokedexEntry('Yanma', 193, 127), 469: PokedexEntry('Yanmega', 469, 127),
    449: PokedexEntry('Hippopotas', 449, 127), 450: PokedexEntry('Hippowdon', 450, 127),
    417: PokedexEntry('Pachirisu', 417, 127),
    434: PokedexEntry('Stunky', 434, 127), 435: PokedexEntry('Skuntank', 435, 127),
    216: PokedexEntry('Teddiursa', 216, 127), 217: PokedexEntry('Ursaring', 217, 127), 901: PokedexEntry('Ursaluna', 901, 127),
    704: PokedexEntry('Goomy', 704, 127), 705: PokedexEntry('Sliggoo', 705, 127), 706: PokedexEntry('Goodra', 706, 127),
    95: PokedexEntry('Onix', 95, 127), 208: PokedexEntry('Steelix', 208, 127),
    111: PokedexEntry('Rhyhorn', 111, 127), 112: PokedexEntry('Rhydon', 112, 127), 464: PokedexEntry('Rhyperior', 464, 127),
    438: PokedexEntry('Bonsly', 438, 127), 185: PokedexEntry('Sudowoodo', 185, 127),
    108: PokedexEntry('Lickitung', 108, 127), 463: PokedexEntry('Lickilicky', 463, 127),
    175: PokedexEntry('Togepi', 175, 31), 176: PokedexEntry('Togetic', 176, 127), 468: PokedexEntry('Togekiss', 468, 127),
    387: PokedexEntry('Turtwig', 387, 31), 388: PokedexEntry('Grotle', 388, 31), 389: PokedexEntry('Torterra', 389, 127),
    92: PokedexEntry('Gastly', 92, 127), 93: PokedexEntry('Haunter', 93, 127), 94: PokedexEntry('Gengar', 94, 127),
    442: PokedexEntry('Spiritomb', 442, 127),
    198: PokedexEntry('Murkrow', 198, 127), 430: PokedexEntry('Honchkrow', 430, 127),
    201: PokedexEntry('Unown', 201, 127),
    363: PokedexEntry('Spheal', 363, 127), 364: PokedexEntry('Sealeo', 364, 127), 365: PokedexEntry('Walrein', 365, 127),
    223: PokedexEntry('Remoraid', 223, 127), 224: PokedexEntry('Octillery', 224, 127),
    451: PokedexEntry('Skorupi', 451, 127), 452: PokedexEntry('Drapion', 452, 127),
    58: PokedexEntry('Growlithe', 58, 63), 59: PokedexEntry('Arcanine', 59, 127),
    431: PokedexEntry('Glameow', 431, 191), 432: PokedexEntry('Purugly', 432, 191),
    66: PokedexEntry('Machop', 66, 63), 67: PokedexEntry('Machoke', 67, 63), 68: PokedexEntry('Machamp', 68, 127),
    441: PokedexEntry('Chatot', 441, 127),
    355: PokedexEntry('Duskull', 355, 127), 356: PokedexEntry('Dusclops', 356, 127), 477: PokedexEntry('Dusknoir', 477, 127),
    393: PokedexEntry('Piplup', 393, 31), 394: PokedexEntry('Prinplup', 394, 31), 395: PokedexEntry('Empoleon', 395, 127),
    458: PokedexEntry('Mantyke', 458, 127), 226: PokedexEntry('Mantine', 226, 127),
    550: PokedexEntry('Basculin', 550, 127), 902: PokedexEntry('Basculegion', 902, 127),
    37: PokedexEntry('Vulpix', 37, 191), 38: PokedexEntry('Ninetales', 38, 127),
    72: PokedexEntry('Tentacool', 72, 127), 73: PokedexEntry('Tentacruel', 73, 127),
    456: PokedexEntry('Finneon', 456, 127), 457: PokedexEntry('Lumineon', 457, 127),
    240: PokedexEntry('Magby', 240, 63), 126: PokedexEntry('Magmar', 126, 63), 467: PokedexEntry('Magmortar', 467, 127),
    436: PokedexEntry('Bronzor', 436, GENDERLESS), 437: PokedexEntry('Bronzong', 437, GENDERLESS),
    239: PokedexEntry('Elekid', 239, 63), 125: PokedexEntry('Electabuzz', 125, 63), 466: PokedexEntry('Electivire', 466, 127),
    207: PokedexEntry('Gligar', 207, 127), 472: PokedexEntry('Gliscor', 472, 127),
    443: PokedexEntry('Gible', 443, 127), 444: PokedexEntry('Gabite', 444, 127), 445: PokedexEntry('Garchomp', 445, 127),
    299: PokedexEntry('Nosepass', 299, 127), 476: PokedexEntry('Probopass', 476, 127),
    100: PokedexEntry('Voltorb', 100, GENDERLESS), 101: PokedexEntry('Electrode', 101, GENDERLESS),
    479: PokedexEntry('Rotom', 479, GENDERLESS),
    433: PokedexEntry('Chingling', 433, 127), 358: PokedexEntry('Chimecho', 358, 127),
    200: PokedexEntry('Misdreavus', 200, 127), 429: PokedexEntry('Mismagius', 429, 127),
    173: PokedexEntry('Cleffa', 173, 191), 35: PokedexEntry('Clefairy', 35, 191), 36: PokedexEntry('Clefable', 36, 127),
    215: PokedexEntry('Sneasel', 215, 127), 903: PokedexEntry('Sneasler', 903, 127),
    361: PokedexEntry('Snorunt', 361, 127), 362: PokedexEntry('Glalie', 362, 127), 478: PokedexEntry('Froslass', 478, 127),
    220: PokedexEntry('Swinub', 220, 127), 221: PokedexEntry('Piloswine', 221, 127), 473: PokedexEntry('Mamoswine', 473, 127),
    712: PokedexEntry('Bergmite', 712, 127), 713: PokedexEntry('Avalugg', 713, 127),
    459: PokedexEntry('Snover', 459, 127), 460: PokedexEntry('Abomasnow', 460, 127),
    570: PokedexEntry('Zorua', 570, 31), 571: PokedexEntry('Zoroark', 571, 31),
    627: PokedexEntry('Rufflet', 627, MALE_ONLY), 628: PokedexEntry('Braviary', 628, MALE_ONLY),
    447: PokedexEntry('Riolu', 447, 31), 448: PokedexEntry('Lucario', 448, 127),
};

sdcs() {
    pokedex[23]?.pokemon;
}