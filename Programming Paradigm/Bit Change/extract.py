def main():
    f=open('aiman.txt','r')
    f1=open('bitchange.txt','w')
    f2=open('bitfreq.txt','w')
    diction ={}
    myline="RandomString"
    while not myline[0]==" " :
        myline=f.readline()
    lastOpcode=myline[10:12]
    name1= myline[32:].split()[0]
    while True :
        try:
            myline=f.readline()
            if myline[0]==" ":
                currentOpcode=myline[10:12]
                if len(myline)>31:
                    name2= myline[32:].split()[0]
                else:
                    name2="   "
                if not name2 in diction :
                    diction[name2]=1
                else:
                    diction[name2]+=1
                r=int('0x'+lastOpcode,16)^int('0x'+currentOpcode,16)
                r=str(bin(r))
                bitchange=r.count('1')	    
                f1.write(str(name1)+"  "+str(lastOpcode)+"  "+str(bitchange)+"\n")
                lastOpcode=currentOpcode
                name1=name2

        except :
            break
    temp="    "
    diction.pop(temp,None)
    for key, value in diction.items():
        f2.write( key+"     "+ str(value)+'\n')
    f1.close()
    f2.close()

if __name__=='__main__':
    main()
              
    
    
