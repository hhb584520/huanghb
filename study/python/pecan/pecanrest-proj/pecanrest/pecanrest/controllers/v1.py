# v1.py
import pecan
from pecan import rest

class VersionController(rest.RestController):
    @pecan.expose('json')
    def get(self):
        return {"api version": "1.0"}
