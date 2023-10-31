#!/bin/python3
import random

def create_lists(target, length):
    t1 = random.randint(0, target)
    t2 = target - t1
    allowed = set([x for x in range(0, target) if x != t1 and x != t2])
    l = []
    for i in range(0, length):
        l.append(random.choice(list(allowed)))
        if target - l[-1] in allowed:
            allowed.remove(target - l[-1])
    i1 = random.randint(0, int(length/2))
    i2 = random.randint(int(length/2), length-1)
    l[i1] = t1
    l[i2] = t2

    return (l, i1, i2)

def create_file(n_entries=100, max_target=1000, max_list_len=100, filename='two_sum'):
    with open(filename, 'w') as f1, open(f'{filename}_answers', 'w') as f2:
        for i in range(0, n_entries):
            target = random.randint(1, max_target)
            l, i1, i2 = create_lists(target, random.randint(1,max_list_len))
            f1.write(f'{target}|{l}\n')
            f2.write(f'{i1},{i2}\n')

create_file()
