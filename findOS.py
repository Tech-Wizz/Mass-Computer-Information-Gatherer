import os
import linecache
import xlwt
from xlwt import Workbook
wb = Workbook()
sheet1 = wb.add_sheet('Sheet 1')

ip = input('Enter first 3 sections of IP "###.###.###.\n')
start = input('What number do you want to start on?\n')
end = input('What number do you want to end with?\n')
s = int(start)
e = int(end)



while s < (e + 1):


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

    row = s - 1
    sheet1.write(row,0, hostName)
    sheet1.write(row,1, "153.90.162." + start)
    sheet1.write(row,2, systemModel)
    
    if '18363' in versionOS:
        sheet1.write(row,3, versionOS)
        sheet1.write(row,5, 'BAD')
    else:
        sheet1.write(row,3, versionOS)
        sheet1.write(row,5, 'GOOD')

    sheet1.write(row,4, nameos)
    os.remove("E:\output" + start + ".txt")
    s += 1
    print("RAN 153.90.162." + start)


#saves results to an excel document
wb.save('computerOS.xls')
print("Program Completed! Save in computerOS.xls!")
