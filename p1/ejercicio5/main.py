from abc import ABC, abstractmethod
import time
from selenium import webdriver
from selenium.webdriver.firefox.options import Options
from selenium.webdriver.common.by import By
import json
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.action_chains import ActionChains

#Estrategia Abstracta
class ScrapingStrategy(ABC):
    @abstractmethod
    def scrape(self, url):
        pass

#Estrategia con BeautifulSoup
class BeautifulScraping(ScrapingStrategy):
    def scrape(self, url):
        #Implementación de la parte de BeautifulSoup
        pass

#Estrategia con Selenium
class SeleniumScraping(ScrapingStrategy):
    def __init__(self):
        options = Options()
        # options.add_argument("--headless")
        # options.headless = True
        # try:
        #     print("Iniciando el driver de Firefox")
        #     self.driver = webdriver.Firefox(options=options)
        # except Exception as e:
        #     print("Se ha producido un error: ", e)
        #     self.driver.quit()
        # # self.driver = webdriver.Firefox(options=options)
        DRIVER_PATH = '/usr/bin/chromedriver'
        self.driver = webdriver.Chrome(executable_path=DRIVER_PATH)
        self.driver.maximize_window()

        

    def scrape(self, url):
        #Implementación de la parte de Selenium
        try:
            print("Iniciando el driver de Firefox")
            self.driver.get(url)
            #Gestionar las cookies
            #self.driver.implicitly_wait(5)

            ActionChains(self.driver).key_down(Keys.TAB).perform()
            ActionChains(self.driver).key_down(Keys.TAB).perform()
            ActionChains(self.driver).key_down(Keys.TAB).perform()
            ActionChains(self.driver).key_down(Keys.TAB).perform()
            ActionChains(self.driver).key_down(Keys.TAB).perform()
            time.sleep(5)
            ActionChains(self.driver).key_down(Keys.ENTER).perform()

            
            elemento = self.driver.find_element(By.XPATH, '//tbody').text
            print(elemento)
            self.driver.quit()
            
            return None
        except Exception as e:
            print("Se ha producido un error: ", e)
            self.driver.quit()
            return None
            
    

#Contexto
class WebScraping:
    def __init__(self, strategy):
        self.strategy = strategy

    def scrape(self, url):
        print("Scraping de la página: ", url)
        data = self.strategy.scrape(url)
        # if data is not None:
        #     # Guardar los datos en un archivo JSON
        #     with open('data.json', 'w') as file:
        #         json.dump(data, file)
        # return data
        print(data)
    
    def set_strategy(self, strategy):
        self.strategy = strategy

#Cliente
def main():
    url = 'https://finance.yahoo.com/quote/'
    print("Vamos a hacer web scraping de la página: ", url)
    web_scraping = WebScraping(SeleniumScraping())
    web_scraping.scrape(url)

if __name__ == '__main__':
    main()
    

    