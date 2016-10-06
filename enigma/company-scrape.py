"""
    Author: Danny Vilela

    The assignment:
        Write a script to scrape a sample site and output its data in JSON.

    Requirements:
        A stable internet connection for ~11 seconds. Otherwise, nothing.

    Output:
        Output file 'solution.json' in the local directory. This script's
        output has been checked against JSON formats: RFC 4627, RFC 7159,
        and ECMA-404 (using https://jsonformatter.curiousconcept.com/).

    Evaluation:
        From the terminal, run:

            python company-scrape.py
"""

import json
import requests
from bs4 import BeautifulSoup


class Company:
    """A representation of a company as listed on edgar"""

    def __init__(self, name='', address_1='', address_2='', city='',
                 state='', zipcode='', phone='', website='', description='',
                 link=''):
        """ Create and populate new Company object

        :param name:        Company's full name
        :param address_1:   Company's first address line
        :param address_2:   Company's second address line
        :param city:        Company's city of residence
        :param state:       Company's state of residence
        :param zipcode:     Company's zipcode of residence
        :param phone:       Company's listed phone number
        :param website:     Company's listed website URL
        :param description: Company's provided description
        :param link:        Company's page link on edgar
        """
        self.name = name
        self.address_line_1 = address_1
        self.address_line_2 = address_2
        self.city = city
        self.state = state
        self.zipcode = zipcode
        self.phone = phone
        self.website = website
        self.description = description
        self.link = link

    # __repr__ is for developers, __str__ is for customers
    def __repr__(self):
        """ Unambiguous representation of Company object: its name

        :return: string representation of the company's name
        """
        return 'Company: %s' % self.name

    def __str__(self):
        """ Readable representation of Company object

        :return: string representation of Company object's attributes
        """
        return 'Company: %s\nDescription: %s\nLink: %s\n' % (self.name,
                                                             self.description,
                                                             self.link)


def main():

    # Define our bare-bones URL -- our page of origin
    base_url = '[REDACTED]'

    print 'Querying all pages on edgar...'

    # Query all of edgar's pages and store their soup-ified versions
    pages = get_pages(base_url)

    print 'Extracting relative paths to all companies...'

    # Prepend our base URL to each link returned by all company page links
    links = [base_url + link for link in get_links(pages, turbo=False)]

    print 'Scraping each company\'s page...'

    # Build all Company objects and store in list
    companies = scrape_company_pages(links, turbo=True, n=10)

    # Output JSON representation of Company list to 'solution.json' file
    print_all_json(companies)

    # Done :)
    print "Done! File \'solution.json\' has been written to local directory."


def get_pages(base_url):
    """ Query all pages on :base_url, assuming relatively simple pagination

    Given a base URL from which to scrape, we look for the 'next' list element
    within the navbar, query that page, store it, query the next page, etc.
    Note: we do assume a relatively trivial pagination schema where ?page=$n$
    is appended to the base URL, where $n$ = [1, 2, 3, 4, ...]

    :return pages: list of soup-ified pages starting from our base URL
        and ending at the last page of the website
    """

    # Set up requirements for scraping
    request = requests.get(base_url)
    soup = BeautifulSoup(request.content, 'html.parser')

    # Add current soup to list of pages :pages
    pages = [soup]

    # Initialize first instance of next page's soup
    next_page_rel = get_next_page(soup)

    # While the next page's relative path is not # (disabled next)
    while next_page_rel != '#':

        # Make a request for the next page, soup-ify, append it to :pages
        next_request = requests.get(str(base_url + next_page_rel))
        next_soup = BeautifulSoup(next_request.content, 'html.parser')
        pages.append(next_soup)

        # Update next page's relative path and start again until the
        # next page's path is disabled (next_page_rel = '#')
        next_page_rel = get_next_page(next_soup)

    # Return our list of soup-ified pages
    return pages


def get_next_page(page_soup):
    """ Given a page soup, determine relative path for next page

    :param page_soup: output from call to BeautifulSoup(), contains
        page's HTML content
    :return: string containing relative path from current page's soup to
        next page, as given in the navbar
    """

    # Find the 'next' tag in the page soup, get its anchor link, and
    # isolate the relative path
    next_rel = str(page_soup.find_all('li', {'class': 'next'})[0].find_all('a')).split('\"')[1]

    # Split the relative path on '/companies' if our path has it since our
    # base URL accounts for '/companies'
    return next_rel.split('/companies')[1] if '/companies' in next_rel else next_rel


def get_links(pages, turbo=False, n=4):
    """ Given a list of soup-ified pages, extract all company links from page

    :param pages: list of pages, output from get_pages() function
    :param turbo: boolean denoting whether we'd like to parallelize the link
        extraction process (True) or not (False)
    :param n: if we opt to parallelize, :n is the number of threads we would
        like to spawn. We default to 4 threads.
    :return: list of relative paths to each company page
    """

    # Initialize container for all company links
    company_links = []

    # If we've opted to parallelize the task of extracting company links
    if turbo:

        # http://i.imgur.com/RCsyMvx.gif -- Ludicrous speed, go!
        from multiprocessing.dummy import Pool as ThreadPool

        # Initialize thread pool
        pool = ThreadPool(n)

        # Parallelize the querying of company pages. Gives us the
        # same result as non-turbo approach -- a list of lists
        company_links = pool.map(get_company_links, pages)

        # Terminate thread resources
        pool.close()
        pool.join()

    else:

        # http://giphy.com/gifs/gED24LbpbRIBO/html5 -- Slow and steady.
        for page in pages:

            # Append each page's link to company links. Note this gives us
            # a list of lists, and we'll take care of that on return.
            company_links.append(get_company_links(page))

    # :company_links is a list of lists, so flatten to a general list,
    # replace spaces with the appropriate '%20', and prepend the '/' to
    # ensure each path is properly formatted with respect to base URL
    return ['/' + link.replace(' ', '%20') for nested_list in company_links for link in nested_list]


def get_company_links(page):
    """ Given a page soup, determine relative path for all companies in page

    :param page: output from call to BeautifulSoup(), contains
        page's HTML content
    :return: list of relative paths to companies on our :page parameter
    """

    # For each link in the page that falls under the 'td' tag, include that
    # string split on the first double quote and instance of '/companies/'
    # if that link contains 'href'. Otherwise it is of no use due to being '#'
    return [str(link).split('\"')[1].split('/companies/')[1] for link in page.find_all('td') if 'href' in str(link)]


def scrape_company_pages(links, turbo=False, n=4):
    """ Scrape individual company pages, create Company objects

    Given a list of valid URLs on edgar that point to a company's particular
    information page, scrape it, build the Company object, and return a list
    of all built companies.

    :param links: list of company URLs (as strings) on edgar
    :param turbo: boolean denoting whether we'd like to parallelize the
        company building process (True) or not (False)
    :param n: if we opt to parallelize, :n is the number of threads we would
        like to spawn. We default to 4 threads.
    :return: list of Company objects :companies
    """

    # Initialize container for Company objects
    companies = []

    # If we've chosen to parallelize company scraping
    if turbo:

        from multiprocessing.dummy import Pool as ThreadPool

        # Initialize thread pool
        pool = ThreadPool(n)

        # Parallelized population of our container for Company objects
        companies = pool.map(create_company, links)

        # Terminate thread resources
        pool.close()
        pool.join()

    else:

        for company_link in links:

            # Scrape the page at :company_link and build a new Company
            # object. Append that object to the :companies list of
            # Company objects.
            companies.append(create_company(company_link))

    # Return a list of populated Company objects
    return companies


def create_company(company_link):
    """ Create a Company object given link to page

    Given a link to a company's page on edgar, build a Company object
    by populating the internal attributes.

    :param company_link: link to a company's page with their information
    :return new_company: populated Company object representing a company
        on edgar
    """

    # Build request for particular company page, soup-ify
    request = requests.get(company_link)
    soup = BeautifulSoup(request.content, 'html.parser')

    # Isolate the required fields from our page, like name, address, etc.
    name = isolate(soup, 'name')
    address_1 = isolate(soup, 'street_address')
    address_2 = isolate(soup, 'street_address_2')
    city = isolate(soup, 'city')
    state = isolate(soup, 'state')
    zipcode = isolate(soup, 'zipcode')
    phone = isolate(soup, 'phone_number')
    website = isolate(soup, 'website')
    description = isolate(soup, 'description')
    link = company_link

    # Create and return our new Company object
    new_company = Company(name=name, address_1=address_1, address_2=address_2,
                          city=city, state=state, zipcode=zipcode, phone=phone,
                          website=website, description=description, link=link)

    return new_company


def isolate(soup, identifier):
    """ Isolate particular HTML id from company page's 'td' tag

    Given a soup-ified company page containing company information,
    isolate and return the stripped piece of company information as
    denoted by :identifier param.

    :param soup: output from call to BeautifulSoup(), contains
        company page's HTML content
    :param identifier: particular id we need to look for on page
    :return: stripped string containing only the text within a particular
        id.
    """

    return str(soup.find_all('td', {'id': identifier})).split('>')[1].split('<')[0]


def print_all_json(companies_list):
    """ Given a list of Company objects, write its attributes as valid JSON

    Iterate over our list of Company objects and write each one in JSON
    format to the 'solution.json' file.

    :param companies_list: list of populated Company objects
    """

    # Open file for writing
    with open('solution.json', 'w') as f:
        # Build JSON output format, including outer brackets and commas
        f.write('{')
        for company in companies_list:
            f.write('\"%s\": %s%s' % (company.name,
                                      json.dumps(vars(company), sort_keys=False, indent=4),
                                      ',' if company != companies_list[-1] else ''))
        f.write('}')


if __name__ == '__main__':
    main()
