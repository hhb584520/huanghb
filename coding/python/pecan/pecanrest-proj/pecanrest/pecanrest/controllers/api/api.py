# api.py
from pecanrest.controllers.api import order
import pecan

class ApiController(object):
    orders = order.OrdersController()
    testhh = order.OrdersController()

    @pecan.expose('json')
    def index(self):
        return {"version": "1.0.0", "info": "test api"}
