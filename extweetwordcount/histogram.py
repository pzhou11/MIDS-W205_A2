import sys

import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

number_input = sys.argv

if len(number_input) != 2:
	print "You have entered an invalid entry. Please enter 2 integers in this example format: 3,8"
	exit(1)

numbers = number_input[1].split(",")

if len(numbers) != 2:
	print "You have entered an invalid entry. Please enter 2 integers in this example format: 3,8"
	exit(1)

first = numbers[0]
second = numbers[1]

try:
   int(first)
except ValueError:
   print("The first value you've entered is not an integer. Please enter an integer")
   exit(1)

try:
   int(second)
except ValueError:
   print("The second value you've entered is not an integer. Please enter an integer")
   exit(1)

if first > second:
   print "The first value you've entered is greater than the second value. Please re-enter with the first value being the smaller number"
   exit(1)

conn = psycopg2.connect(database = "tcount", user = "postgres", password = "pass", host = "localhost", port = "5432")
conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
cur = conn.cursor()

# get list of all words with values between those conditions
cur.execute("SELECT word, count FROM tweetwordcount WHERE count >= %s AND count <= %s ORDER BY count DESC;", (first, second))
records = cur.fetchall()
for rec in records:
	print rec[0],":",rec[1]

