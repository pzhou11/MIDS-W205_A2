Exercise 2

Step by Step Instructions:

1) Change user to w205

2) Clone the github repository by entering:
git clone https://github.com/pzhou11/MIDS_W205_A2_Exercise2.git

3) Change directory to extweetwordcount

4) Run the following command to create the tcount database and tweetwordcount
tables (this will also delete previous tcount database and tweetwordcount if
they exist):
python create_psql_table.py

5) Start storm by tweet stream by entering: sparse run

6) After it has run for awhile press ctrl+c to interrupt the stream.

7) Run the following python scripts to query the database:
python finalresults.py
-If you enter 1 word, this script will return the word as well as the count of
the number of occurences word from the stream
-If you enter 0 words, this script will return all words and the count of the
occurences of each of those words alphabetically
-Anything else will give the user a corresponding error message

python histogram.py int,int
-Enter 2 integers in the format of integer,integer
-This will return all words in the stream and their number of occurences if
the number of occurences of the word is greater than or equal to the first
integer and less than or equal to the second integer.
-Any incorrect input will give the user a corresponding error message


