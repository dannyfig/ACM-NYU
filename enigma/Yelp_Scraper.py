
# Import required modules
import requests
from bs4 import BeautifulSoup
from pprint import pprint
import sys


class Listing:

    def __init__(self, name='', review_n=-1, dollars=-1, food_type=[],
                 neighborhood='', address='', zip=-1, phone=''):
        self.name = name
        self.review_n = review_n
        self.dollars = dollars
        self.food_type = food_type
        self.neighborhood = neighborhood
        self.address = address
        self.zip = zip
        self.phone = phone


def main():

    # Define what we're looking for and where
    what, where = sys.argv[1], sys.argv[2]

    # Build parameter dictionary
    params = {'find_desc': what, 'find_loc': where}

    # Define our bare-bones URL -- our page of origin
    base_url = "https://www.yelp.com/search?"

    # For every Yelp parameter and user-provided value,
    # append to our base_url
    for param, value in params.items():
        base_url = "{0}{1}={2}&".format(base_url, param, value)

    # Got an extra ampersand
    base_url = base_url[:-1]

    # Milestone 1
    print(base_url)

    # Retrieve web page using requests
    request = requests.get(base_url)

    # Parse the HTML returned by :request with BeautifulSoup
    soup = BeautifulSoup(request.content, 'html.parser')

    returned_text = {}

    # Chrome devtools
    i = 1
    for record in soup.find_all('li', 'regular-search-result'):
        returned_text[i] = record.text
        i += 1

    clean = {index: " ".join(result.split()) for index, result in returned_text.items()}

    pprint(clean)

    # To get the next page?

    # Chrome devtools
    rel_next = soup.find_all('a', 'u-decoration-none next pagination-links_anchor', href=True)[0]['href']

    # Aha! It just adds the start=n parameter. Sly!
    base_url += "start=10"

    # Rinse and repeat
    request = requests.get(base_url)



if __name__ == '__main__':
    main()
