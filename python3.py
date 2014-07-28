#!/usr/local/bin/python3

import time
import json
import mysql.connector
from sqlalchemy import create_engine

# Fibonacci Numbers

def fibIter(n):
    if n < 2:
        return n
    fibPrev = 1
    fib = 1
    for num in range(2, n):
        fibPrev, fib = fib, fib + fibPrev
    return fib

def time_fibo():
  start_time = time.time()
  out = ''
  for n in range(40):
    out += str(fibIter(n))

  end_time = time.time()
  return (out + "\nFibonacci Numbers\t%g milliseconds" % ((end_time - start_time)*1000) + '\n\n')


def time_1mill():
  start_time = time.time()
  out = ''
  for n in range(0, 1000000):
    out = n

  end_time = time.time()
  return("1,000,000\t%g milliseconds" % ((end_time - start_time)*1000) + '\n\n')


def count_sub(str, sub):
    return str.count(sub)

def time_countstring():
  start_time = time.time()
  out = ''

  out += str(count_sub('the three truths','th'))
  out += str(count_sub('ababababab','abab'))

  end_time = time.time()
  return("Count String\t%g milliseconds" % ((end_time - start_time)*1000) + '\n\n')


def time_json():
  start_time = time.time()
  j = json.loads('[ { "id": "0001", "type": "donut", "name": "Cake", "ppu": 0.55, "batters": { "batter": [ { "id": "1001", "type": "Regular" }, { "id": "1002", "type": "Chocolate" }, { "id": "1003", "type": "Blueberry" }, { "id": "1004", "type": "Devil\'s Food" } ] }, "topping": [ { "id": "5001", "type": "None" }, { "id": "5002", "type": "Glazed" }, { "id": "5005", "type": "Sugar" }, { "id": "5007", "type": "Powdered Sugar" }, { "id": "5006", "type": "Chocolate with Sprinkles" }, { "id": "5003", "type": "Chocolate" }, { "id": "5004", "type": "Maple" } ] }, { "id": "0002", "type": "donut", "name": "Raised", "ppu": 0.55, "batters": { "batter": [ { "id": "1001", "type": "Regular" } ] }, "topping": [ { "id": "5001", "type": "None" }, { "id": "5002", "type": "Glazed" }, { "id": "5005", "type": "Sugar" }, { "id": "5003", "type": "Chocolate" }, { "id": "5004", "type": "Maple" } ] }, { "id": "0003", "type": "donut", "name": "Old Fashioned", "ppu": 0.55, "batters": { "batter": [ { "id": "1001", "type": "Regular" }, { "id": "1002", "type": "Chocolate" } ] }, "topping": [ { "id": "5001", "type": "None" }, { "id": "5002", "type": "Glazed" }, { "id": "5003", "type": "Chocolate" }, { "id": "5004", "type": "Maple" } ] }]')
  d = (json.dumps(j))

  end_time = time.time()
  return(d + "\nJSON\t%g milliseconds" % ((end_time - start_time)*1000) + '\n\n')

def time_sec():
  start_time = time.time()
  time.sleep(1)
  end_time = time.time()
  return("\One second\t%g milliseconds" % ((end_time - start_time)*1000) + '\n\n')


def time_all():
  return (time_fibo() + time_1mill() + time_json() + time_countstring() + time_mysql() + time_sqlalchemy())

# MySQL Performance, SELECT and display 100 rows 
# pip install --allow-external mysql-connector-python mysql-connector-python

def time_mysql(): 

  start_time = time.time()
  out = ''
  cnx = mysql.connector.connect(user='root', password='',
                                host='127.0.0.1',
                                database='mysql')
  cursor = cnx.cursor()
  query = ("SELECT name, example, url FROM help_topic LIMIT 0,100")
  cursor.execute(query)

  for (title, description, last_update) in cursor:
    out += ("{}, {} is here {}".format(
      title, description, last_update))

  cursor.close()

  cnx.close()

  end_time = time.time()
  return("MySQL\t%g milliseconds" % ((end_time - start_time)*1000) + '\n\n')

# SQALchemy Performance, SELECT and display 100 rows 
# pip install sqlalchemy

def time_sqlalchemy(): 

  start_time = time.time()
  out = ''
  engine = create_engine('mysql+mysqlconnector://root@localhost/mysql')
  conn = engine.connect()
  result = conn.execute("SELECT name, example, url FROM help_topic LIMIT 0,100")
  for row in result:
    out += row['name'] + ', ' + row['example'] + ' is here ' + row['url']

  result.close()
  end_time = time.time()
  
  return("SQLAlchemy\t%g milliseconds" % ((end_time - start_time)*1000) + '\n\n')


print(time_all())
