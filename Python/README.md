# Mass-Computer-Information-Gatherer
This program is used in a corporate setting. The systems that this is being used on are on a managed domain with an admin acount on all the computers. With this I can you this admin accounts and use the terminal to find all the windows versions located on the computers accross departments. This makes it easy to find bad os systems that could potentially harm infrastructure on the computers.

```
os.system('cmd /c "color a & ipconfig > e:\myip.txt"')
myip = linecache.getline(r"e:\myip.txt", 8)
myip = myip.lstrip("   IPv4 Address. . . . . . . . . . . :")
os.remove("E:\myip.txt")

#get user input and sets values
ip = input('Enter first 3 sections of IP "###.###.###.\n')
start = input('What number do you want to start on?\n')
end = input('What number do you want to end with?\n')
s = int(start)
e = int(end)


while s < (e + 1):

    row = s - 1

    os.system('cmd /c "color a & ping ' + ip + start + ' > e:\live' + start + '.txt"')
    reply = linecache.getline(r"e:\live" + start + ".txt", 3).rstrip('\n')
    reply = reply.lstrip("Reply from " + myip + ": ")
    reply = reply.lstrip("\n")
    os.remove("E:\live" + start + ".txt")

    if (reply == "Destination host unreachable."):
        print(reply)
        sheet1.write(row,1, "###.##.###." + start)
        sheet1.write(row,0, reply)
    else:
        os.system('cmd /c "color a & systeminfo /s ' + ip + start + ' > e:\output' + start + '.txt"')
        #os.system('cmd /c "color a & systeminfo /s 153.90.162.' + s + '|findstr /i \"host OS\" > e:\output.txt"')

        #converts the data from the txt file to varibles
    
        hostName = linecache.getline(r"E:\output" + start + ".txt", 2)
        hostName = hostName.lstrip("Host Name:                 ")
        systemModel = linecache.getline(r"E:\output" + start + ".txt", 14)
        systemModel = systemModel.lstrip("System Model:              ")
        versionOS = linecache.getline(r"E:\output" + start + ".txt", 4)
        versionOS = versionOS.lstrip("OS Version:                   10.0")
        nameos = linecache.getline(r"E:\output" + start + ".txt", 3)
        nameos = nameos.lstrip("OS Name:                   ")
    
        ##puts the data collected 

        sheet1.write(row,0, hostName)
        sheet1.write(row,1, "###.##.###." + start)
        sheet1.write(row,2, systemModel)
    
        if '18363' in versionOS:
            sheet1.write(row,3, versionOS)
            sheet1.write(row,5, 'BAD')
        else:
            sheet1.write(row,3, versionOS)
            sheet1.write(row,5, 'GOOD')

        sheet1.write(row,4, nameos)
        os.remove("E:\output" + start + ".txt")
        
    
    start = str(s)
    print("RAN ###.##.###." + start)
    s += 1


#saves results to an excel document
wb.save('computerOS.xls')
print("Program Completed! Save in computerOS.xls!")
```
![IDLEShell](https://kruizechristensen.github.io/images/projects/MSUITInfoFinder/IDLEShell.png)

## Terminal Comands Used

systeminfo /s ###.###.###.###  == Returns information about computer for that IP


cmd /c color a  == Changes Color of terminal to green codes below

Value	Color
0	Black
1	Blue
2	Green
3	Aqua
4	Red
5	Purple
6	Yellow
7	White
8	Gray
9	Light blue
a	Light green
b	Light aqua
c	Light red
d	Light purple
e	Light yellow
f	Bright white


