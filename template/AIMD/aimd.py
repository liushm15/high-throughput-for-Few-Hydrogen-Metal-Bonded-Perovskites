f = open("result-hopping.txt","r")

compound = ""
for line in f:
    if "Yes" in line:
        s = line.strip().split('\t')
        s1 = ''.join(s) + '\n'
        s2 = s1.split()
        compound += s2[0]
        compound += "\t"

f.close()

f = open("compounds.txt","w")
f.write(compound)
f.close()