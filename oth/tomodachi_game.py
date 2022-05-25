from pathlib import Path
from bs4 import BeautifulSoup

from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

import requests
import sys
import time

REFERER    = 'https://klmag.net/'
USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 12_4)' \
           + 'AppleWebKit/605.1.15 (KHTML, like Gecko)' \
           + 'Version/15.4 Safari/605.1.15'
HEADERS    = {'Referer': REFERER}
BASE_LINK  = 'https://klmag.net/rzdz-tomodachi-game-raw-chapter-XXX.html'


def normalize_number(k, n):
    upper_bound = f'{n}'
    upper_bound_digits = len(upper_bound)
    k_str = f'{k}'
    k_digits = len(k_str)
    return '0' * (upper_bound_digits - k_digits + 1) + k_str


def download_file(url, name, headers=None, cookies=None):
    try:
        r = requests.get(url, headers=headers, cookies=cookies, stream=True)
        with open(f'{name}', 'wb') as f:
            for byte_chunk in r.iter_content(chunk_size=4096):
                f.write(byte_chunk)
    except Exception as e:
        print(f'Problems downloading here: -> {url}')
        print(e)


def download_chapter(driver, nchapter, path, verbose=False, sleep_sec=0):
    link = f'https://klmag.net/rzdz-tomodachi-game-raw-chapter-{nchapter}.html'
    if verbose:
        print(link)
    driver.get(link)
    wait = WebDriverWait(driver, 10)
    wait.until(EC.presence_of_all_elements_located((By.CLASS_NAME, 'chapter-img')))
    pages = driver.find_elements(by=By.XPATH, value='//img[@class="chapter-img"]')
    srcs = [p.get_attribute('src') for p in pages]

    nch = normalize_number(nchapter, 999)
    path = path / f'tomodachi_game_chapter_{nch}'
    if not path.exists():
        path.mkdir()
    
    for i, src in enumerate(srcs):
        ii = normalize_number(i+1, 999)
        name_page = f'ch_{nch}-pag_{ii}.jpeg'
        if sleep_sec > 0:
            time.sleep(sleep_sec)
        if verbose:
            print('->', src)
            print(f'Downloading page {name_page}, chapter {nch}')
        download_file(src, str(path/name_page), headers=HEADERS)
        if verbose:
            print('==> Done!')
    if verbose:
        print('Chapter {nchapter} FINISHED')


def download_range_chapters(low=1, high=94, driver=None, path=None,
                            verbose=False, sleep_sec=0):
    if driver is None:
        driver = webdriver.Firefox()
    if path is None:
        path = Path.home() / 'Manga'
        if not path.exists():
            path.mkdir()
        path = path / 'Tomodachi_Game'
        if not path.exists():
            path.mkdir()
        
    for i in range(low,high+1):
        download_chapter(driver, nchapter=i, path=path,
                         verbose=verbose, sleep_sec=sleep_sec)



if len(sys.argv) < 2:
    download_range_chapters(low=1, high=100)
elif len(sys.argv) >= 3:
    low = int(sys.argv[1])
    high = int(sys.argv[2])
    sleep_sec = 0
    if len(sys.argv) >= 4:
        sleep_sec = int(sys.argv[3])
    verbose = False
    if len(sys.argv) >= 5:
        if sys.argv[4] == '--verbose':
            verbose = True
    download_range_chapters(low=low, high=high,
                            verbose=verbose,sleep_sec=sleep_sec)
else:
    print('Usage: python tomodachi_game.py first last [seconds] [--verbose]')
    sys.exit()
    

