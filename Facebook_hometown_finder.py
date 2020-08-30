#1.search a name in facebook
#2.taking the address of that person
#3.going to google maps entering the person's address
#4.screen shoot the result
import time
import pyautogui # control the gui (mouse , keyboard , screen )
from selenium import webdriver

#username = input("enter your facebook user name (you can login with your phone number , if you connected it to facebook):")
#passwd =  input("enter your faceboob passward:")
#path = input("enter full path of where you want to save the img:")
username = "0585553210"
passwd = ""
name = input("enter the name of the person you want to search:")
page = webdriver.Chrome(executable_path=r'C:\webdrivers\chromedriver.exe')
page.get("https://www.facebook.com/login/")

#login
page.find_element_by_xpath("//input[@id=\"email\"]").send_keys(username) #using username
page.find_element_by_xpath("//input[@name=\"pass\"]").send_keys(passwd) #using the passward
page.find_element_by_xpath("//button[contains(text(), 'Log In')]").click()

#search
time.sleep(10)
page.find_element_by_xpath("//input[@placeholder=\"Search\"]").send_keys(name)
time.sleep(17)
pyautogui.press('esc')
pyautogui.press('enter')

#getting into the profile
time.sleep(10)
page.find_element_by_xpath("//a[contains(@href, \"/profile.php\")]").click() #getting into the first profile
time.sleep(10)
page.find_element_by_xpath("//a[contains(text(), 'About')]").click()
time.sleep(10)
content = page.find_element_by_xpath("/html/body/div[1]/div[3]/div[1]/div/div[2]/div[2]/div[1]/div/div[2]/div[3]/div/div[1]/div[2]/div/ul/li/div/div[2]/div/div/div[1]/ul/li[3]/div/div/div/div[1]/a").text
time.sleep(4)
print(content)
time.sleep(10)

#Gmaps
page.get('https://www.google.co.il/maps')
time.sleep(5)
page.find_element_by_xpath("//input[@id=\"searchboxinput\"]").send_keys(content)
time.sleep(4)
pyautogui.press('enter')
time.sleep(6)


##screenshot
datascreenshot = pyautogui.screenshot()
datascreenshot.save(r'C:\Users\Matan\PycharmProjects\net4u\im.png')
page.close()
