# ascii 码：0-9: 48-57; a-z: 97-122; A-Z: 65-90

name = "summary.txt"
number = [1,1,3]

data_Tenergy = open(name,"r")
data_element = open("单质能量.dat","r")

E_element = {}

for line in data_element:
    s = line.strip().split('\t')
    E_element[s[0]]=float(s[1])

data_element.close()

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

E_total = []

for line in data_Tenergy:
    s = line.strip().split('\t')
    s1 = ''.join(s) + '\n'
    s2 = s1.split()
    E_total.append([get_name(s2[0]),float(s2[-2])])

data_Tenergy.close()

f1 = open("formation.dat","w")

compound = ""
for s in E_total:
    E_formation = s[1]
    name = ""
    n = 0
    for i in range(len(number)):
        E_formation = E_formation - E_element[s[0][i]]*number[i]
        name += s[0][i]+str(number[i])
        n += number[i]
    if E_formation <= 0.01:
        f1.write(name+"\t"+str(E_formation/n)+"\n")
        for i in range(len(number)):
            compound += s[0][i]
            if number[i]>1:
                compound += str(number[i])
        compound += "\t"
f1.close()


f2 = open("compounds.txt","w")
f2.write(compound)
f2.close()



