# -*- coding:utf-8 -*-
import time
import netsnmp
import datetime
import pymysql
def get_snmp_info():
    timestr = str(datetime.datetime.now()).split('.')[0]
    sysName_oid = netsnmp.Varbind("sysName")#系统名称
    location_oid = netsnmp.Varbind("sysLocation") #物理位置
    sysContact_oid = netsnmp.Varbind("sysContact") #联系人信息
    ip_list = get_ip_list()
    for i in ip_list:
        result = netsnmp.snmpwalk(location_oid,sysContact_oid,sysName_oid,Version = 2,DestHost='{0}'.format(i), Community='Community',Timeout=1000000)
        if result:
            sysName = result[0]
            sysContact = result[2]
        else:
            sysName = ''
            sysContact = ''
        try:
            insert_mysql(i,sysName,sysContact,timestr)
        except Exception as e:
            print e.args
        print i + '\t' + str(sysName) + '\t' + str(sysContact)

def insert_mysql(ip,sysName,sysContact,create_time):
    # dict1 = get_snmp_info()
    connect = pymysql.Connect(
        host='localhost',
        port=3306,
        user='onemore',
        passwd='onemore',
        db='day1',
        charset='utf8'
    )
    cursor = connect.cursor()
    insert_sql = "insert into snmp_info(ip,sysName,sysContact,create_time) VALUES ('{0}','{1}','{2}','{3}')".format(ip,sysName,sysContact,create_time)
    # print insert_sql
    cursor.execute(insert_sql)
    connect.commit()
    cursor.close()
    connect.close()
def get_ip_list():
    ip = []
    file01 = open('snmp_list.txt','r')
    content = file01.readlines()
    for i in content:
        ip.append(i.split('\n')[0])
    file01.close()
    return ip
if __name__ == '__main__':
    get_snmp_info()
    # print get_ip_list()
