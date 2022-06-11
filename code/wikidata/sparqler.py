# (c) 2022 Steven J. Baskauf
# This program is released under a GNU General Public License v3.0 http://www.gnu.org/licenses/gpl-3.0
# Author: Steve Baskauf
# Date: 2022-06-07

import requests
import datetime
import time
import json

class Sparqler:
    """Build SPARQL queries of various sorts

    Parameters
    -----------
    useragent : str
        Required if using the Wikidata Query Service, otherwise optional.
        Use the form: appname/v.v (URL; mailto:email@domain.com)
        See https://meta.wikimedia.org/wiki/User-Agent_policy
    endpoint: URL
        Defaults to Wikidata Query Service if not provided.
    method: str
        Possible values are "post" (default) or "get". Use "get" if read-only query endpoint.
        Must be "post" for update endpoint.
    sleep: float
        Number of seconds to wait between queries. Defaults to 0.1
        
    Required modules:
    -------------
    requests, datetime, time
    """
    def __init__(self, method='post', endpoint='https://query.wikidata.org/sparql', useragent=None, sleep=0.1):
        # attributes for all methods
        self.http_method = method
        self.endpoint = endpoint
        if useragent is None:
            if self.endpoint == 'https://query.wikidata.org/sparql':
                print('You must provide a value for the useragent argument when using the Wikidata Query Service.')
                print()
                raise KeyboardInterrupt # Use keyboard interrupt instead of sys.exit() because it works in Jupyter notebooks
        self.sleep = sleep

        self.requestheader = {}
        if useragent:
            self.requestheader['User-Agent'] = useragent
        
        if self.http_method == 'post':
            self.requestheader['Content-Type'] = 'application/x-www-form-urlencoded'

    def query(self, query_string, form='select', verbose=False, **kwargs):
        """Sends a SPARQL query to the endpoint.
        
        Parameters
        ----------
        form : str
            The SPARQL query form.
            Possible values are: "select" (default), "ask", "construct", and "describe".
        mediatype: str
            The response media type (MIME type) of the query results.
            Some possible values for "select" and "ask" are: "application/sparql-results+json" (default) and "application/sparql-results+xml".
            Some possible values for "construct" and "describe" are: "text/turtle" (default) and "application/rdf+xml".
            See https://docs.aws.amazon.com/neptune/latest/userguide/sparql-media-type-support.html#sparql-serialization-formats-neptune-output
            for response serializations supported by Neptune.
        verbose: bool
            Prints status when True. Defaults to False.
        default: list of str
            The graphs to be merged to form the default graph. List items must be URIs in string form.
            If omitted, no graphs will be specified and default graph composition will be controlled by FROM clauses
            in the query itself. 
            See https://www.w3.org/TR/sparql11-query/#namedGraphs and https://www.w3.org/TR/sparql11-protocol/#dataset
            for details.
        named: list of str
            Graphs that may be specified by IRI in a query. List items must be URIs in string form.
            If omitted, named graphs will be specified by FROM NAMED clauses in the query itself.
            
        Returns
        -------
        If the form is "select" and mediatype is "application/json", a list of dictionaries containing the data.
        If the form is "ask" and mediatype is "application/json", a boolean is returned.
        If the mediatype is "application/json" and an error occurs, None is returned.
        For other forms and mediatypes, the raw output is returned.

        Notes
        -----
        To get UTF-8 text in the SPARQL queries to work properly, send URL-encoded text rather than raw text.
        That is done automatically by the requests module for GET. I guess it also does it for POST when the
        data are sent as a dict with the urlencoded header. 
        See SPARQL 1.1 protocol notes at https://www.w3.org/TR/sparql11-protocol/#query-operation        
        """
        query_form = form
        if 'mediatype' in kwargs:
            media_type = kwargs['mediatype']
        else:
            if query_form == 'construct' or query_form == 'describe':
            #if query_form == 'construct':
                media_type = 'text/turtle'
            else:
                media_type = 'application/sparql-results+json' # default for SELECT and ASK query forms
        self.requestheader['Accept'] = media_type
            
        # Build the payload dictionary (query and graph data) to be sent to the endpoint
        payload = {'query' : query_string}
        if 'default' in kwargs:
            payload['default-graph-uri'] = kwargs['default']
        
        if 'named' in kwargs:
            payload['named-graph-uri'] = kwargs['named']

        if verbose:
            print('querying SPARQL endpoint')

        start_time = datetime.datetime.now()
        if self.http_method == 'post':
            response = requests.post(self.endpoint, data=payload, headers=self.requestheader)
        else:
            response = requests.get(self.endpoint, params=payload, headers=self.requestheader)
        elapsed_time = (datetime.datetime.now() - start_time).total_seconds()
        self.response = response.text
        time.sleep(self.sleep) # Throttle as a courtesy to avoid hitting the endpoint too fast.

        if verbose:
            print('done retrieving data in', int(elapsed_time), 's')

        if query_form == 'construct' or query_form == 'describe':
            return response.text
        else:
            if media_type != 'application/sparql-results+json':
                return response.text
            else:
                try:
                    data = response.json()
                except:
                    return None # Returns no value if an error. 

                if query_form == 'select':
                    # Extract the values from the response JSON
                    results = data['results']['bindings']
                else:
                    results = data['boolean'] # True or False result from ASK query 
                return results           

    def update(self, request_string, mediatype='application/json', verbose=False, **kwargs):
        """Sends a SPARQL update to the endpoint.
        
        Parameters
        ----------
        mediatype : str
            The response media type (MIME type) from the endpoint after the update.
            Default is "application/json"; probably no need to use anything different.
        verbose: bool
            Prints status when True. Defaults to False.
        default: list of str
            The graphs to be merged to form the default graph. List items must be URIs in string form.
            If omitted, no graphs will be specified and default graph composition will be controlled by USING
            clauses in the query itself. 
            See https://www.w3.org/TR/sparql11-update/#deleteInsert
            and https://www.w3.org/TR/sparql11-protocol/#update-operation for details.
        named: list of str
            Graphs that may be specified by IRI in the graph pattern. List items must be URIs in string form.
            If omitted, named graphs will be specified by USING NAMED clauses in the query itself.
        """
        media_type = mediatype
        self.requestheader['Accept'] = media_type
        
        # Build the payload dictionary (update request and graph data) to be sent to the endpoint
        payload = {'update' : request_string}
        if 'default' in kwargs:
            payload['using-graph-uri'] = kwargs['default']
        
        if 'named' in kwargs:
            payload['using-named-graph-uri'] = kwargs['named']

        if verbose:
            print('beginning update')
            
        start_time = datetime.datetime.now()
        response = requests.post(self.endpoint, data=payload, headers=self.requestheader)
        elapsed_time = (datetime.datetime.now() - start_time).total_seconds()
        self.response = response.text
        time.sleep(self.sleep) # Throttle as a courtesy to avoid hitting the endpoint too fast.

        if verbose:
            print('done updating data in', int(elapsed_time), 's')

        if media_type != 'application/json':
            return response.text
        else:
            try:
                data = response.json()
            except:
                return None # Returns no value if an error converting to JSON (e.g. plain text) 
            return data           

    def load(self, file_location, graph_uri, s3='', verbose=False, **kwargs):
        """Loads an RDF document into a specified graph.
        
        Parameters
        ----------
        s3 : str
            Name of an AWS S3 bucket containing the file. Omit load a generic URL.
        verbose: bool
            Prints status when True. Defaults to False.
        
        Notes
        -----
        The triplestore may or may not rely on receiving a correct Content-Type header with the file to
        determine the type of serialization. Blazegraph requires it, AWS Neptune does not and apparently
        interprets serialization based on the file extension.
        """
        if s3:
            request_string = 'LOAD <https://' + s3 + '.s3.amazonaws.com/' + file_location + '> INTO GRAPH <' + graph_uri + '>'
        else:
            request_string = 'LOAD <' + file_location + '> INTO GRAPH <' + graph_uri + '>'
        
        if verbose:
            print('Loading file:', file_location, ' into graph: ', graph_uri)
        data = self.update(request_string, verbose=verbose)
        return data

    def drop(self, graph_uri, verbose=False, **kwargs):
        """Drop a specified graph.
        
        Parameters
        ----------
        verbose: bool
            Prints status when True. Defaults to False.
        """
        request_string = 'DROP GRAPH <' + graph_uri + '>'

        if verbose:
            print('Deleting graph:', graph_uri)
        data = self.update(request_string, verbose=verbose)
        return data

# -----------------
# Body of script
# -----------------
labels = [
    {'string': '尼可罗·马基亚维利', 'language_code': 'zh'},
    {'string': '"I Hate You For Hitting My Mother," Minneapolis', 'language_code': 'en'},
    {'string': "A Picture from an Outline of Women's Manners - The Wedding Ceremony", 'language_code': 'en'}    
]

values = ''
for label in labels:
    values += "'''" + label['string'] + "'''@" + label['language_code'] + '\n'

query_string = '''select distinct ?item ?label where {
  VALUES ?value
  {
  ''' + values + '''}
?item rdfs:label|skos:altLabel ?value.
?item rdfs:label ?label.
FILTER(lang(?label)='en')
  }
'''
#print(query)

user_agent = 'TestAgent/0.1 (mailto:email@domain.com)'
wdqs = Sparqler(useragent=user_agent)
data = wdqs.query(query_string)
if data is None:
    print("Error")
else:
    print(json.dumps(data, indent=2))
#print(wdqs.response)
