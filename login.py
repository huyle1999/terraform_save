from selenium import webdriver
from selenium.webdriver.chrome.options import Options

options.binary_location = "/usr/bin/chromedriver"
driver = webdriver.Chrome(chrome_options=options)

#adjust mode 
options.add_argument('--ignore-certificate-errors')
options.add_argument("--test-type")
options.addArguments("test-type");
options.addArguments("start-maximized");
options.addArguments("--window-size=1920,1080");
options.addArguments("--enable-precise-memory-info");
options.addArguments("--disable-popup-blocking");
options.addArguments("--disable-default-apps");
options.addArguments("test-type=browser");
options.AddArgument("--incognito");
options.AddArgument("--no-sandbox");

USERNAME = 'johnle'
PASSWORD = '30111999'

#driver = webdriver.Chrome("chromedriver")
#driver = webdriver.Chrome(executable_path=DRIVER_LOCATION, options=options)
driver.get('http://192.168.17.101:32000/login?from=%2F')

user_input = driver.find_element_by_id('j_username')
user_input.send_keys(USERNAME)

password_input = driver.find_element_by_name('j_password')
password_input.send_keys(PASSWORD)

login_button = driver.find_element_by_name('Submit')
login_button.click()


