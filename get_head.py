import requests
import pymysql
import datetime
def get_html():
    timestr = str(datetime.datetime.now()).split('.')[0]
    url = select_mysql()
    if not url:
        url = 'https://www.qqak89.com/enter/pc.html'
    user_agent = 'Mozilla/4.0 (compatible; MSIE 5.5; Windows NT)'
    headers = {'User-Agent': user_agent}
    try:
        r = requests.head(url,headers=headers)
        http_code = r.status_code
        if http_code == 301:
            headers_info = r.headers
            new_url = headers_info['Location']
            oper_mysql(new_url,timestr)
    except Exception as e:
        print(e.args)

def oper_mysql(url,time):
    connect = pymysql.Connect(
        host='localhost',
        port=3306,
        user='onemore',
        passwd='onemore',
        db='day1',
        charset='utf8'
    )
    cursor = connect.cursor()
    sql = "insert into url_info(url,create_time) values('{0}','{1}')".format(url,time)
    cursor.execute(sql)
    connect.commit()
    cursor.close()
    connect.close()
def select_mysql():
    new_url = ''
    connect = pymysql.Connect(
        host='localhost',
        port=3306,
        user='onemore',
        passwd='onemore',
        db='day1',
        charset='utf8'
    )
    cursor = connect.cursor()
    sql = "select url from url_info order by id DESC limit 1"
    cursor.execute(sql)
    try:
        for i in cursor.fetchone():
            new_url = i
    except Exception as e:
        print(e.args)
    cursor.close()
    connect.close()
    if new_url:
        return new_url
    else:
        return None
if __name__ == '__main__':
    get_html()
