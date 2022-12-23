import sys

HEIGHT = 6
WIDTH = 6
PREDICATE = "arato"


if len(sys.argv) == 3:
    HEIGHT = int(sys.argv[1])
    WIDTH = int(sys.argv[2])


for i in range(HEIGHT):
    for j in range(WIDTH):
        this = WIDTH*i+j
        print(f"cam{this}")

print("-")

for i in range(HEIGHT):
    for j in range(WIDTH):
        this = WIDTH*i+j
        print(f"(CAMPO cam{this})")

print("-")        

for i in range(HEIGHT-1):
    for j in range(WIDTH-1):
        this = WIDTH*i+j
        on_right = WIDTH*i+j+1
        down = WIDTH*(i+1)+j
        print(f"(CONNESSO cam{this} cam{on_right})")
        print(f"(CONNESSO cam{on_right} cam{this})")
        print(f"(CONNESSO cam{this} cam{down})")
        print(f"(CONNESSO cam{down} cam{this})")

print("-")        

for i in range(HEIGHT-1):
    this = WIDTH*i+(WIDTH-1)
    down = WIDTH*(i+1)+(WIDTH-1)
    print(f"(CONNESSO cam{this} cam{down})")
    print(f"(CONNESSO cam{down} cam{this})")

print("-")

for j in range(WIDTH-1):
    this = WIDTH*(HEIGHT-1)+j
    on_right = this+1
    print(f"(CONNESSO cam{this} cam{on_right})")
    print(f"(CONNESSO cam{on_right} cam{this})")

print("-")    

for i in range(HEIGHT):
    for j in range(WIDTH):
        this = HEIGHT*i+j
        print(f"({PREDICATE} cam{this})")
