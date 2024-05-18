f1 = open("energy.dat","r")
f2 = open("structure.dat","r")

n=0
for line in f2:
    n+=1
f2.close()

f3=open("hopping.txt","w")
if n > 1:
    m=0
    data=[]
    for line in f1:
        m+=1
        if m>=2:
            s = line.strip().split('\t')
            s1 = ''.join(s) + '\n'
            s2 = s1.split()
            if m==2:
                data.append(float(s2[1]))
                data.append(float(s2[1]))
            else:
                if float(s2[1]) < data[-1]:
                    data[-1] = float(s2[1])
    if data[1] < data[0]:
        f3.write("Sorry, 113 is not stable!\t" + str(data[0])+ "\t"+ str(data[1]))
    else: f3.write("Yes, 113 is stable!\t" + str(data[0]))

else:
    m=0
    for line in f1:
        m+=1
        if m==2:
            s = line.strip().split('\t')
            s1 = ''.join(s) + '\n'
            s2 = s1.split()
            f3.write("Yes, 113 is stable!\t" + s2[1])


