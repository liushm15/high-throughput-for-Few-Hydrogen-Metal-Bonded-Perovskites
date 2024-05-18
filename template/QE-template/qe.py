# ascii 码：0-9: 48-57; a-z: 97-122; A-Z: 65-90

name="NAME"

def get_name(name:str): #通过 ascii 码拆分元素
    Name = []
    tmp = ""
    for i in name:
        if ord(i) in range(65,91):
            if len(tmp):
                Name.append(tmp)
            tmp = i
        elif ord(i) in range(97,122):
            tmp += i
        elif ord(i) in range(48,58):
            Name.append(tmp)
    return Name


data_input = open("../..//pseudo/data_input","r")
dir = {}
for line in data_input:
    s = line.strip()#.split("\t")
    s1 = ''.join(s) + '\n'
    s2 = s1.split()
    dir[s2[0]]=[s2[1],s2[2]]

data_input.close()

Compound = get_name(name)

f = open("input", "w")
f.write("eg: AX3H" + "\n")
f.write(Compound[0] + "\t" + dir[Compound[0]][0] + "\t" + dir[Compound[0]][1] + "\n")
f.write(Compound[2] + "\t" + dir[Compound[2]][0] + "\t" + dir[Compound[2]][1] + "\n")
f.write(Compound[1] + "\t" + dir[Compound[1]][0] + "\t" + dir[Compound[1]][1] + "\n")
f.close()
