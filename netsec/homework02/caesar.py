import re
import sys

from collections import Counter

from typing import Dict, List

frequent_eng_letters = ['e', 'a', 'r', 'i', 'o',
                        't', 'n', 's', 'l', 'c',
                        'u', 'd', 'p', 'm', 'h',
                        'g', 'b', 'f', 'y', 'w',
                        'k', 'v', 'x', 'z', 'j',
                        'q']

def preprocessing(file: str) -> List[str]:
    return re.findall(r'\S', open(file).read())

def mapping(letters: List[str]) -> Dict[str, str]:
    mapp = dict()
    counter = Counter(letters)
    most_common = counter.most_common(min(len(counter),
                                          len(frequent_eng_letters)))
    for k, tup in enumerate(most_common):
        mapp[tup[0]] = frequent_eng_letters[k]
    return mapp

def decipher(file_in: str, file_out: str, mapp: Dict[str, str]):
    with open(file_in) as f:
        text = f.read().lower()
    with open(file_out, 'w+') as f:
        for char in text:
            # MODIFY MANUALLY HERE WITH
            # ADDITIONAL CORRISPONDENCES
            
            if char == '$':
                f.write(' ')
            elif char == 'g':
                f.write('e')
            elif char == 'y':
                f.write('a')
            elif char == 'm':
                f.write('t')
            elif char in mapp.keys():
                f.write(mapp[char])
            else:
                f.write(f'[{char}]')
    return

# print('Most common 10 letters',
#      Counter(preprocessing('test.txt')).most_common(10))

mapp = mapping(preprocessing(sys.argv[1]))
print('Mapping: ', mapp)

decipher(sys.argv[1], sys.argv[2], mapp)
