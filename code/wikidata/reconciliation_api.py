# reconciliation_api.py, containing a function to reconcile a search string with Wikidata using the OpenRefine Reconciliation API
version = '0.1.0'
created = '2023-03-14'

# (c) 2023 Vanderbilt University. This program is released under a GNU General Public License v3.0 http://www.gnu.org/licenses/gpl-3.0
# Author: Steve Baskauf
# For more information, see https://github.com/HeardLibrary/digital-scholarship/tree/master/code/wikidata

# Referred to code at https://github.com/jvfe/reconciler/blob/master/reconciler/webutils.py#L14-L47
# Reconciler documentation: https://jvfe.github.io/reconciler/
# Reconciliation API documentation: https://reconciliation-api.github.io/specs/0.2/#reconciliation-queries
# Wikidata reconciliation for OpenRefine: https://wikidata.reconci.link/

# Problems solved by help from the OpenRefine forum: https://forum.openrefine.org/t/accessing-reconciliation-api-via/471

import requests
import json
from typing import List, Dict, Tuple, Any, Optional

def reconcile(search_string: str, http: requests.Session, limit=5, type='Q5') -> List[Dict[str, Any]]:
    """Reconcile a search string with Wikidata using the OpenRefine Reconciliation API.
    
    Notes
    -----
    - The query type defaults to human (Q5)
    - The results limit defaults to 5
    """
    reconciliation_endpoint = 'https://wikidata.reconci.link/en/api'

    query_string = '''{
        "q0": {
            "query": "''' + search_string + '''",
            "type": ["''' + type + '''"],
            "limit": ''' + str(limit) + ''',
            "type_strict": "should"
        }
    }'''

    payload = {'queries': query_string}
    response = http.post(reconciliation_endpoint, data=payload)
    data = response.json()

    results = data['q0']['result']
    return results

# Example usage
http = requests.Session() # Create a session to keep the connection open

search_string = 'Albert Einstein'
results = reconcile(search_string, http)
print(json.dumps(results, indent=2))

# Example output:
'''
[
  {
    "description": "German-born theoretical physicist; developer of the theory of relativity (1879\u20131955)",
    "features": [
      {
        "id": "all_labels",
        "value": 100
      }
    ],
    "id": "Q937",
    "match": true,
    "name": "Albert Einstein",
    "score": 100.0,
    "type": [
      {
        "id": "Q5",
        "name": "human"
      }
    ]
  },
  {
    "description": "Swiss-American engineer and educator (1904-1973)",
    "features": [
      {
        "id": "all_labels",
        "value": 86
      }
    ],
    "id": "Q123371",
    "match": false,
    "name": "Hans Albert Einstein",
    "score": 86.0,
    "type": [
      {
        "id": "Q5",
        "name": "human"
      }
    ]
  }
]
'''