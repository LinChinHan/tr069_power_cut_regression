import threading
import time
import os
import sys
import Console
import random


#Initial parameters
DUT_PORT = '/dev/ttyUSB0'
RELAY_PORT= '/dev/ttyACM0'
DUT_BAUD_RATES = 921600
RELAY_BAUD_RATES = 115200
counter = 0
platform = None
MR5_FW="KVD21_0.00.21_ca1e35c4eff6501f002c5980b55603207ccce286_debug.bin"


#Functions
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

#main function
if __name__ == '__main__':

    flag = 1

    while(flag == 1):
        #Start ACS Server
        acs = threading.Thread(target=start_Services)
        acs.start()

        counter=counter+1
        print("##### Run :", counter)
        time.sleep(5)
        if(counter==1):
            DUT_ser = Console.Open_COM(DUT_PORT, DUT_BAUD_RATES)
        else:
            DUT_ser.open()
        #Triger TR69 download. . .
        if(Console.IsOpen(DUT_ser)):
            #Console.Write_To_COM(DUT_ser, ' ')
            #tmp = Console.Read_From_COM(DUT_ser, 1)
            #tmp will be string insted of list
            #print("Read from com output: ", tmp)
            #if ('login:' in tmp):
            #    Console.Write_To_COM(DUT_ser, 'root')
            #    tmp = Console.Read_Until(DUT_ser, 'Password:', None)
            Console.Write_To_COM(DUT_ser, 'root')
            tmp = Console.Read_From_COM(DUT_ser, 2)
            print(tmp)
            if ('Password:' in tmp):
                Console.Write_To_COM(DUT_ser,"pz3W72z92yf2vaMvpKqc33jxsPxu5x7h")
                #tmp = Console.Read_Until(DUT_ser, 'OpenWrt:', 2)
                tmp = Console.Read_From_COM(DUT_ser, 2)
                print(tmp)
            if ('OpenWrt:' in tmp):
                platform='MR5'
                print("##### Platform is : " + platform )
                print("##### Do Upgrade!!!")
                Console.Write_To_COM(DUT_ser, ' ')
                Console.Write_To_COM(DUT_ser, 'tr69_trigger connreq')
                tmp = Console.Read_From_COM(DUT_ser, 1)
                Console.Save_COM_Log(DUT_ser, tmp, "./logs/console_logs_trigger.txt")
            elif ('KVD21:' in tmp):
                platform='MR6'
                print("##### Platform is : " + platform )
                print("##### Do Downgrade!!!")
                Console.Write_To_COM(DUT_ser, ' ')
                Console.Write_To_COM(DUT_ser, 'ls -al /data/')
                tmp = Console.Read_From_COM(DUT_ser, 1)
                #if firmware is not in board, do wget.
                if (MR5_FW not in tmp):
                    print("##### Cannot find the FW \"" + MR5_FW + "\" on board. Start to download firmware from ACS Server. . .")
                    Console.Write_To_COM(DUT_ser, "cd /data/ ; wget http://129.16.11.217/" + MR5_FW )
                    time.sleep(80)
                tmp = Console.Read_From_COM(DUT_ser, 1) #Flush
                Console.Write_To_COM(DUT_ser, 'ls -al /data/')
                tmp = Console.Read_From_COM(DUT_ser, 1)

                if(MR5_FW in tmp):
                    print("#### Trigger downgrade. . . ")
                    # Since that the firmware will disapear after triggering firmwar upgrade, copy file to do it.
                    Console.Write_To_COM(DUT_ser, 'cd /data/ && cp ' + MR5_FW + ' target_image.bin')
                    time.sleep(5)
                    Console.Write_To_COM(DUT_ser, 'dmcli eRT setv Device.X_TMOBILE.RESTfulAPI.UpgradeFirmware string \"/data/target_image.bin\"')
                    time.sleep(3)
                    Console.Write_To_COM(DUT_ser, 'dmcli eRT getv Device.X_TMOBILE.RESTfulAPI.UpgradeStatus')
                    tmp = Console.Read_From_COM(DUT_ser, 2)
                    Console.Save_COM_Log(DUT_ser, tmp, "./logs/console_logs_trigger.txt")
                    print("####### Triger result ########")
                    f = open("./logs/console_logs_trigger.txt",'r')
                    for line in f.readlines():
                        print(line)
                    print("#############################\n")
                    if( "Upgrading" in tmp):
                        print("#### Trigger successfully!!!")
                    else:
                        print("#### Trigger Failed!!!")
                else:
                    print("#### [Wget] Download firmware from ACS Server failed . . .")
                    print("#### [Wget] Please check if the server is reachable or not.")
                    sys.exit(1) #Return error code 1

        if( platform == "MR5"):
            if ( counter % 3 == 1 ):
                # less than 60 secs for download period.
                exec_time = random.randint(1, 60)
            elif ( counter % 3 == 2):
                # 61 ~ 180 secs for upgrade period (keep in 0% to upgrade).
                exec_time = random.randint(61, 180)
            else:
                # 180 ~ 210 secs for upgrading process(0% ~ 100%).
                exec_time = random.randint(180, 210)
            print("#### Upgrading!!!!")
        elif( platform == "MR6"):
            exec_time = random.randint(1, 20)
            print("#### downgrading!!!")

        print("##### Test will run ", exec_time, " secs then going to power down device.")
        time.sleep(exec_time)
        tmp = Console.Read_From_COM(DUT_ser, 2)
        Console.Save_COM_Log(DUT_ser, tmp, "./logs/console_logs_execute.txt")

        #Power down/up device
        print("#### Start to power down/up device. . . ####")
        if(counter==1):
            Relay_ser = Console.Open_COM(RELAY_PORT, RELAY_BAUD_RATES)
        else:
            Relay_ser.open()
        if(Console.IsOpen(Relay_ser)):
            Console.Write_To_COM_No_N(Relay_ser, 'a')
            Console.Write_To_COM_No_N(Relay_ser, 'relay 1 off')
            time.sleep(2)
            Console.Write_To_COM_No_N(Relay_ser, 'relay 1 on')
            Console.Close_COM(Relay_ser)
            
        #Stop ACS Server and HTTP Server
        acs_stop = threading.Thread(target=stop_Services)
        acs_stop.start()
        acs_stop.join()
        acs.join()
        print("#### FINISHED run ", counter, " ####")

        #Waiting DUT reboot and power up again
        if(platform == "MR5"):
            print("#### Waiting boot up for 230 secs ####")
            time.sleep(230)
        elif(platform == "MR6"):
            print("#### Waiting boot up for 120 secs ####")
            time.sleep(120)
        tmp = Console.Read_From_COM(DUT_ser, 2)
        Console.Save_COM_Log(DUT_ser, tmp, "./logs/console_logs_booting.txt")

        #Check result part
        print("#### Checking the result . . . ####")
        DUT_ser.close()
        DUT_ser.open()
        tried=0
        #Tried method, since that the login will meet failed sometimes. Giving retry in 10 times.
        while(tried<=10):
            #Console.Write_To_COM(DUT_ser, ' ')
            #tmp = Console.Read_Until(DUT_ser, 'login:', None)
            #if ('login:' in tmp):
            #    Console.Write_To_COM(DUT_ser, 'root')
            #    tmp = Console.Read_Until(DUT_ser, 'Password:', None)
            Console.Write_To_COM(DUT_ser, 'root')
            tmp = Console.Read_Until(DUT_ser, 'Password:', 2)
            if ('Password:' in tmp):
                Console.Write_To_COM(DUT_ser, 'pz3W72z92yf2vaMvpKqc33jxsPxu5x7h')
                #Console.Write_To_COM(DUT_ser, ' ')
                #tmp = Console.Read_Until(DUT_ser, 'OpenWrt:', 3)
                tmp = Console.Read_From_COM(DUT_ser, 1)
            if('OpenWrt:' in tmp):
                Console.Write_To_COM(DUT_ser, ' ')
                Console.Write_To_COM(DUT_ser, 'uci show | grep glb-cfg')
                tmp = Console.Read_From_COM(DUT_ser, 1)
                Console.Save_COM_Log(DUT_ser, tmp, "./logs/check.txt")
                tried=99
            elif ('KVD21:' in tmp):
                Console.Write_To_COM(DUT_ser, ' ')
                Console.Write_To_COM(DUT_ser, 'arc-board show')
                tmp = Console.Read_From_COM(DUT_ser, 1)
                Console.Save_COM_Log(DUT_ser, tmp, "./logs/check.txt")
                tried=99
            else:
                print("#### Login failed, retried. . .")
                time.sleep(5)
            tried=tried+1
        print("################### Check ##################\n")
        f = open('./logs/check.txt','r')
        for line in f.readlines():
            print(line)
        print("############################################\n\n")

        if ("HB5GGW" in tmp):
            flag = 1
            print("#### Upgrade Test Succesfully!!!!!!! ####")
        elif("model     : KVD21" in tmp):
            flag = 1
            print("#### Downgrade Test Succesfully!!!!!!! ####")
        else:
            flag = 0
            print("#### FAILED!!!!!! ####")
            print("#### STOP Script in ", counter, " ####")
        print("#### Finished run ", counter, " ####")
        if ( Console.IsOpen(DUT_ser) ):
            Console.Close_COM(DUT_ser)
