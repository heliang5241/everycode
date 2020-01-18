import requests
import pymysql
import datetime
def get_html():
    timestr = str(datetime.datetime.now()).split('.')[0]
    url = 'https://www.qqak89.com/enter/pc.html'
    # url = 'https://www.qqct88.com'
    user_agent = 'Mozilla/4.0 (compatible; MSIE 5.5; Windows NT)'
    headers = {'User-Agent': user_agent}
    try:
        r = requests.head(url,headers=headers)
        http_code = r.status_code
        if http_code == 301:
            headers_info = r.headers
            new_url = headers_info['Location']
            print(new_url)
    except Exception as e:
        print(e.args)

def oper_mysql():
    connect = pymysql.Connect(
        host='localhost',
        port=3306,
        user='onemore',
        passwd='onemore',
        db='day1',
        charset='utf8'
    )
    cursor = connect.cursor()
    sql = ''
    cursor.execute(sql)

if __name__ == '__main__':
    get_html()
