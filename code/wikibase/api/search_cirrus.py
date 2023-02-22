# search_cirrus.py, containing a function for performing a Cirrus search of Wikidata (or other wikibase) using its API.
version = '0.1.0'
created = '2023-02-22'

# (c) 2023 Vanderbilt University. This program is released under a GNU General Public License v3.0 http://www.gnu.org/licenses/gpl-3.0
# Author: Steve Baskauf
# For more information, see https://github.com/HeardLibrary/linked-data/tree/master/vanderbot

# General information on Wikimedia Search: https://www.mediawiki.org/wiki/API:Search_and_discovery
# Wikimedia Search Platform team page: https://www.mediawiki.org/wiki/Wikimedia_Search_Platform
# Details on CirrusSearch are at https://www.mediawiki.org/wiki/Help:CirrusSearch
# Wikidata specific details are at https://www.mediawiki.org/wiki/Help:Extension:WikibaseCirrusSearch

# Refer to https://www.mediawiki.org/wiki/API:Search_and_discovery for search API documentation
# "search" query action using CirrusSearch (Elastic-based search engine):
# https://www.wikidata.org/wiki/Special:ApiSandbox#action=query&format=json&list=search&formatversion=2&srsearch=baskauf
# Returns Q IDs and descriptions ("snippets")

import requests
import json
from typing import List, Dict, Tuple, Any, Optional

# See https://meta.wikimedia.org/wiki/User-Agent_policy for details of Wikimedia User-Agent policy
user_agent_header = 'VanderSearchBot/' + version + ' (https://github.com/HeardLibrary/linked-data/tree/master/vanderbot; mailto:steve.baskauf@vanderbilt.edu)'
request_header_dictionary = {
	'Accept' : 'application/json',
	'User-Agent': user_agent_header
}
search_session = requests.Session()
# Set default User-Agent header so you don't have to send it with every request
search_session.headers.update(request_header_dictionary)


def search_cirrus(search_string: str, http: requests.Session, api_endpoint='https://www.wikidata.org/w/api.php') -> List[dict]:
	"""Search for a string using CirrusSearch (Elastic-based search engine)

	Parameters
	----------
	search_string : str
		String to use in elastic search, produces same results as the Wikidata search box
	http : requests.Session
		Requests HTTP session to use for search calls
	api_endpoint : str
		URL of the endpoint, defaults to Wikidata
	
	Returns
	-------
	List[dict] : List of search results with keys "qid", "description", and "label"
	"""
	request_string = '''{
		"action": "query",
		"format": "json",
		"list": "search",
		"formatversion": "2",
		"srsearch": "''' + search_string + '''"
	}'''

	response = http.get(api_endpoint, params=json.loads(request_string))
	data = response.json()
	#print(json.dumps(data, indent=2))

	hits = data['query']['search']

	# Look up the label for each item
	for index, hit in enumerate(hits):
		# "title" in the search results is the Q ID		
		request_string = '''{
			"action": "wbgetentities",
			"format": "json",
			"ids": "''' + hit['title'] + '''",
			"props": "labels"
		}'''
		response = http.get(api_endpoint, params=json.loads(request_string))
		data = response.json()
		#print(json.dumps(data, indent=2))

		# Match the Q ID to the label and add the label to the hits list
		try:
			hits[index]['label'] = data['entities'][hit['title']]['labels']['en']['value']
		except:
			hits[index]['label'] = ''

	#print(json.dumps(hits, indent=2))

	# Clean up the hits list by removing useless keys and renaming others
	clean_hits = []
	for hit in hits:
		del hit['ns']
		del hit['pageid']
		del hit['size']
		del hit['wordcount']
		del hit['timestamp']
		hit['qid'] = hit['title']
		del hit['title']
		hit['description'] = hit['snippet']
		del hit['snippet']
		clean_hits.append(hit)

	return clean_hits
	
search_string = 'Black practical theology'
hits = search_cirrus(search_string, search_session)
print(json.dumps(hits, indent=2))
