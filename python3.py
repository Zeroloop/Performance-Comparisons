#!/usr/local/bin/python3

import time

start_time = time.time()

# Fibonacci Numbers

def fibIter(n):
    if n < 2:
        return n
    fibPrev = 1
    fib = 1
    for num in range(2, n):
        fibPrev, fib = fib, fib + fibPrev
    return fib

for n in range(40):
    print(fibIter(n))

end_time = time.time()

print
print("First 40 Fibonacci Numbers\t%g milliseconds" % ((end_time - start_time)*1000))

print
print

# JSON Encoding / Decoding

start_time = time.time()

for n in range(0, 1000000):
    print

end_time = time.time()
print("1,000,000\t%g milliseconds" % ((end_time - start_time)*1000))

print
print

import json

j = json.loads('[ { "id": "0001", "type": "donut", "name": "Cake", "ppu": 0.55, "batters": { "batter": [ { "id": "1001", "type": "Regular" }, { "id": "1002", "type": "Chocolate" }, { "id": "1003", "type": "Blueberry" }, { "id": "1004", "type": "Devil\'s Food" } ] }, "topping": [ { "id": "5001", "type": "None" }, { "id": "5002", "type": "Glazed" }, { "id": "5005", "type": "Sugar" }, { "id": "5007", "type": "Powdered Sugar" }, { "id": "5006", "type": "Chocolate with Sprinkles" }, { "id": "5003", "type": "Chocolate" }, { "id": "5004", "type": "Maple" } ] }, { "id": "0002", "type": "donut", "name": "Raised", "ppu": 0.55, "batters": { "batter": [ { "id": "1001", "type": "Regular" } ] }, "topping": [ { "id": "5001", "type": "None" }, { "id": "5002", "type": "Glazed" }, { "id": "5005", "type": "Sugar" }, { "id": "5003", "type": "Chocolate" }, { "id": "5004", "type": "Maple" } ] }, { "id": "0003", "type": "donut", "name": "Old Fashioned", "ppu": 0.55, "batters": { "batter": [ { "id": "1001", "type": "Regular" }, { "id": "1002", "type": "Chocolate" } ] }, "topping": [ { "id": "5001", "type": "None" }, { "id": "5002", "type": "Glazed" }, { "id": "5003", "type": "Chocolate" }, { "id": "5004", "type": "Maple" } ] }]')
print(json.dumps(j))

end_time = time.time()
print("JSON\t%g milliseconds" % ((end_time - start_time)*1000))

print
print

# MySQL Performance, SELECT and display 100 rows 
# pip3 install --allow-external mysql-connector-python mysql-connector-python

import mysql.connector

start_time = time.time()

cnx = mysql.connector.connect(user='root', password='',
                              host='127.0.0.1',
                              database='sakila')
cursor = cnx.cursor()
query = ("SELECT title, description, last_update FROM film LIMIT 0,100")
cursor.execute(query)

for (title, description, last_update) in cursor:
  print("{}, {} was updated on {}".format(
    title, description, last_update))

cursor.close()

cnx.close()

end_time = time.time()
print("JSON\tElapsed time was %g milliseconds" % ((end_time - start_time)*1000))

