import string
import Console
import time


DUT_PORT = '/dev/ttyUSB0'
RELAY_PORT= '/dev/ttyACM0'
DUT_BAUD_RATES = 921600
RELAY_BAUD_RATES = 115200

s = b'ab,cd,\r\nabcde\r\nasd'

print(s)
a=s.decode()
print(a)
print('======')



if 'cde' in a:
    print("OK!")


r=str(s)
mylist = r.split(",")
print('after split')
print(mylist)
print('=====')
mylist = [x.replace("\\r\\n\'","") for x in mylist]
mylist = [x.replace("b\'","") for x in mylist]
a=0
for line in mylist:
    print(line)
    a=a+1
    print(a)


DUT_ser = Console.Open_COM(DUT_PORT,DUT_BAUD_RATES)
Console.Write_To_COM(DUT_ser, 'ls -al')
a = Console.Read_From_COM(DUT_ser, 1)
print(a)
Console.Write_To_COM(DUT_ser, 'uname -a')
a = Console.Read_From_COM(DUT_ser, 1)
print(a)
