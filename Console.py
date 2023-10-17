import serial
import time
import sys

def Flush_Com(ser):
    print ("Flush_Com")
    ser.flushOutput()
    ser.flushInput()

def Close_COM(ser):
    print ("Close COM")
    ser.close()

def Save_COM_Log(ser, tmp, file_path):
    print ("Save COM Log")
    mylist = tmp.split(",")
    mylist = [x.replace("\\r\\n\'","") for x in mylist]
    #print ("Replace n r . . . \n")
    #print (mylist)
    mylist = [x.replace("b\'","") for x in mylist]
    #print ("Replace b . . . \n")
    #print (mylist)
    #tmp = [x.replace("\r\n","") for x in tmp]
    f = open(file_path, "w")
    for line in mylist:
        f.write(line)
        #print(line)
        f.write('\n')
    f.close()

def Read_From_COM(ser, read_time):
    print ("Read From COM")
    ser.timeout=(int(read_time))
    #byte string
    #s = str(ser.readlines())
    #unicode string
    #s = str.encode(ser.readlines())
    s = str(ser.readlines())
    return s

def Open_COM(port, rate):
    print ("Open COM")
    ser = serial.Serial(port, int(rate), timeout=5)
    print (ser.name)
    return ser

def IsOpen(ser):
    print ("Check IsOpen")
    para=ser.isOpen()
    return para

def Write_To_COM(ser, string):
    print ("Write to COM")
    #ser.write(str(string)+'\r')
    ser.write(str.encode(string+'\r'))

def Read_Until(ser, string, read_time):
    print ("Start to read until : ", string)
    ser.timeout=(int(read_time))
    tmp = ser.read_until(string.encode())
    print("Read output is : ", tmp.decode())
    return tmp.decode()

