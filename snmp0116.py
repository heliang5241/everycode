# -*- coding:utf-8 -*-
import time
import netsnmp
import datetime
import pymysql
def get_snmp_info():
    dict1 = {}
    timestr = str(datetime.datetime.now()).split('.')[0]
    # print timestr
    startTime = time.time()
    sysName_oid = netsnmp.Varbind("sysName")#系统名称
    location_oid = netsnmp.Varbind("sysLocation") #物理位置
    sysContact_oid = netsnmp.Varbind("sysContact") #联系人信息
    result = netsnmp.snmpwalk(location_oid,sysContact_oid,sysName_oid,Version = 2,DestHost='10.0.0.140', Community='Community',Timeout=1000000)
    try:
        # print result[0]
        # print result[2]
        if result[0] == 'NKB' and result[2] == 'ILO6CU833L2S1.':
            endTime = time.time()
            cost_time = endTime-startTime
            chuli_time = '%.2f' % (cost_time)
            dict1['chuli_time'] = chuli_time
        else:
            dict1['chuli_time'] = 4
    except Exception as e:
        dict1['chuli_time'] = 4
    dict1['insert_time'] = timestr
    return dict1
def insert_mysql():
    dict1 = get_snmp_info()
    connect = pymysql.Connect(
        host='localhost',
        port=3306,
        user='onemore',
        passwd='onemore',
        db='day1',
        charset='utf8'
    )
    cursor = connect.cursor()
    insert_sql = "insert into a1(chuli_time,insert_time) VALUES ('{0}','{1}')".format(dict1['chuli_time'],dict1['insert_time'])
    #print insert_sql
    cursor.execute(insert_sql)
    connect.commit()
    cursor.close()
    connect.close()

if __name__ == '__main__':
    # print str(datetime.datetime.now()).split('.')[0]
    insert_mysql()
    # print get_snmp_info()
