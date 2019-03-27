# -*- coding: utf-8  -*-

import family

# The official ABC Wiki.

class Family(family.Family):

    def __init__(self):

        family.Family.__init__(self)

        self.name          = 'ldwg'
        self.langs         = { 'ldwg': '18.205.159.211:8181', }
        self.namespaces[4] = { '_default':  u'LDWG',       }
        self.namespaces[5] = { '_default':  u'LDWG talk',  }

    def version(self, code):
        return "1.6.1"

    def path(self, code):
        return '/wiki/index.php'
