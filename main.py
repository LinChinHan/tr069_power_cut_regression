import threading
import time
import os
import sys
import Console
import random

DUT_PORT = '/dev/ttyUSB0'
RELAY_PORT= '/dev/ttyACM0'
DUT_BAUD_RATES = 921600
RELAY_BAUD_RATES = 115200
counter = 0


def start_Services():
    os.system("make start")

def stop_Services():
    os.system("make stop")


def keep_recording(ser):
    print("current loation is ", os.system("pwd"))
    os.system("rm ./logs/console_logs_booting.txt")
    try:
        while True:
            while DUT_ser.in_waiting:
                data_raw = ser.readline()
                data = data_raw.decode()
                os.system("echo ", data, " >> ./logs/console_logs_booting.txt")
                #print('recv: original：', data_raw)
                #print('recv: transcode：', data)
    
    except KeyboardInterrupt:
        ser.close()
        ser.close()
        print('bye!')


if __name__ == '__main__':

    flag = 1

    while(flag == 1):
        #Start ACS Server
        acs = threading.Thread(target=start_Services)
        acs.start()

        counter=counter+1
        print("##### Run :", counter)
        time.sleep(5)

        #Triger TR69 download. . .
        DUT_ser = Console.Open_COM(DUT_PORT, DUT_BAUD_RATES)
        if(Console.IsOpen(DUT_ser)):
            Console.Flush_Com(DUT_ser)
            Console.Write_To_COM(DUT_ser, ' ')
            tmp = Console.Read_Until(DUT_ser, "login", 2)
            if ("login" in tmp):
                Console.Write_To_COM(DUT_ser, 'root')
                tmp = Console.Read_Until(DUT_ser, "Password", 2)
            if ("Password" in tmp):
                Console.Write_To_COM(DUT_ser, 'pz3W72z92yf2vaMvpKqc33jxsPxu5x7h')
                tmp = Console.Read_Until(DUT_ser, "OpenWrt:", 2)
            if ("OpenWrt:" in tmp):
                Console.Write_To_COM(DUT_ser, ' ')
                Console.Write_To_COM(DUT_ser, 'tr69_trigger connreq')
                tmp = Console.Read_From_COM(DUT_ser, 1)
                Console.Save_COM_Log(DUT_ser, tmp, "./logs/console_logs_trigger.txt")
            else:
                print("Cannot get shell!")
                #Stop ACS Server and HTTP Server
                acs_stop = threading.Thread(target=stop_Services)
                acs_stop.start()
                acs_stop.join()
                acs.join()
                exit(1)
        if ( counter % 3 == 1 ):
            # less than 80 secs for download period.
            exec_time = random.randint(1, 80)
        elif ( counter % 3 == 2):
            # 81 ~ 200 secs for upgrade period (keep in 0% to upgrade.
            exec_time = random.randint(81, 200)
        else:
            # 200 ~ 260 secs for upgrading process(0% ~ 100%).
            exec_time = random.randint(200, 260)

        Console.Flush_Com(DUT_ser)
        print("##### Upgrade test will run ", exec_time, " secs then going to power down device.")
        time.sleep(exec_time)
        tmp = Console.Read_From_COM(DUT_ser, 3)
        Console.Save_COM_Log(DUT_ser, tmp, "./logs/console_logs_execute.txt")

        #Power down/up device
        print("#### Start to power down/up device. . . ####")
        Relay_ser = Console.Open_COM(RELAY_PORT, RELAY_BAUD_RATES)
        if(Console.IsOpen(Relay_ser)):
            Console.Write_To_COM(Relay_ser, 'a')
            Console.Write_To_COM(Relay_ser, 'relay 1 off')
            time.sleep(2)
            Console.Flush_Com(DUT_ser)
            Console.Write_To_COM(Relay_ser, 'relay 1 on')
            Console.Close_COM(Relay_ser)
            
        #Stop ACS Server and HTTP Server
        acs_stop = threading.Thread(target=stop_Services)
        acs_stop.start()
        acs_stop.join()
        acs.join()
        print("#### FINISHED TEST ####")

        #Waiting DUT reboot and power up again
        print("#### Waiting boot up for 200 secs ####")
        time.sleep(200)
        tmp = Console.Read_From_COM(DUT_ser, 3)
        Console.Save_COM_Log(DUT_ser, tmp, "./logs/console_logs_booting.txt")

        #Check result part
        print("#### Checking if the result . . . ####")
        Console.Flush_Com(DUT_ser)
        Console.Write_To_COM(DUT_ser, ' ')
        tmp = Console.Read_Until(DUT_ser, "login", 2)
        if ("login" in tmp):
            Console.Write_To_COM(DUT_ser, 'root')
            tmp = Console.Read_Until(DUT_ser, "Password", 2)
        if ("Password" in tmp):
            Console.Write_To_COM(DUT_ser, 'pz3W72z92yf2vaMvpKqc33jxsPxu5x7h')
            tmp = Console.Read_Until(DUT_ser, "OpenWrt", 2)
        if ("OpenWrt" in tmp):
            Console.Write_To_COM(DUT_ser, ' ')
            Console.Write_To_COM(DUT_ser, 'uci show | grep glb-cfg')
            tmp = Console.Read_From_COM(DUT_ser, 3)
            Console.Save_COM_Log(DUT_ser, tmp, "./logs/check.txt")
            #Console.Write_To_COM(DUT_ser, 'exit')
        else:
            print("Cannot get shell!!!, Test Failed!!!!")
            #Stop ACS Server and HTTP Server
            acs_stop = threading.Thread(target=stop_Services)
            acs_stop.start()
            acs_stop.join()
            acs.join()
            exit(1)
        if ("HB5GGW" in tmp):
            flag = 1
            print("#### Succesfully!!!!!!! ####")
        else:
            flag = 0
            print("#### FAILED!!!!!! ####")
            print("#### STOP Script in ", counter, " ####")
        if ( Console.IsOpen(DUT_ser) ):
            Console.Close_COM(DUT_ser)
