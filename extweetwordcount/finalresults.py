import sys

import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")

cur = conn.cursor()

# error message for more than 1 word
if len(sys.argv) > 2:
        print "You have entered more than 1 word. Please enter no words or  only 1 word."
        exit(1)

# output count for 1 word
if len(sys.argv) == 2:
        word_input = sys.argv[1]
        cur.execute("SELECT word, count FROM tweetwordcount WHERE word = %s;", (word_input,))
	word_count = cur.fetchone()
	if word_count == None:
		print "Total number of occurrences of", word_input, ":0"
        else:
		print "Total number of occurrences of", word_input, ":", word_count[1]
        conn.commit()
        exit(0)

# output if no words entered
if len(sys.argv) == 1:
        cur.execute("SELECT word, count FROM tweetwordcount ORDER BY word")
        records = cur.fetchall()
        for rec in records:
                print "word = ", rec[0]
                print "count = ", rec[1], "\n"
        conn.commit()

conn.close()


