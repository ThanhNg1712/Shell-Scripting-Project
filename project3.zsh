#!/bin/zsh



echo "Hello there! Welcome!"

echo "1. How many chapters in the book?"
chapter_count=$(grep -o "^CHAPTER [IVX]*" tomsawyer.txt|sort -u|wc -l)
echo "The book has $chapter_count chapters"

echo "2. How many empty lines in the book?"
empty_line_count=$(grep -c "^[[:space:]]*$" tomsawyer.txt)
echo "The book has $empty_line_count empty lines"


echo "3. How often do the names 'Tom' and 'Huck' appear in the book?"
tom_count=$(grep -o -i "Tom" tomsawyer.txt | wc -l)
huck_count=$(grep -o -i "Huck" tomsawyer.txt | wc -l)
echo "The name 'Tom' appears $tom_count times in the book"
echo "The name 'Huck' appears $huck_count times in the book"

echo "4. How often do the names 'Tom' and 'Huck' appear together in one line?"
together_count=$(grep -c -i "Tom.*Huck\|Huck.*Tom" tomsawyer.txt)
echo "The names 'Tom' and 'Huck' appear together in one line $together_count times in the book"

echo "5. Go to line 1234 of the file. What is the third word?"
third_word=$(sed -n '1234p' tomsawyer.txt | awk '{print $3}')
echo "The third word on line 1234 is: $third_word"

echo "6. How many lines and words in total in the book?"
line_count=$(wc -l < tomsawyer.txt)
word_count=$(wc -w < tomsawyer.txt)

echo "The book has $line_count lines"
echo "The book has $word_count words"

echo "7. Translate all words of the book into lowercase"
tr '[:upper:]' '[:lower:]' < tomsawyer.txt > tomsawyer_lowercase.txt
echo "The lower case transformation is saved in the tomsawyer_lowercase.txt"

echo "8. Count how often each word in the book appears"
echo " the file is transfered to lower cases before counting unique words"
tr '[:upper:]' '[:lower:]' < tomsawyer.txt | tr -cs '[:alnum:]' '\n' | sort | uniq -c | sort -nr > word_count.txt
echo "The word count has been saved to 'word_count.txt'"

echo "9. Print the word with highest frequency."
most_frequent_word=$(head -n 1 word_count.txt | awk '{print $2}')
echo "The most frequent word is '$most_frequent_word'."

echo "10. Translate all words of the book into lowercase, and count how often each word in the book appears and print the most frequent word"
most_frequent_word=$(tr '[:upper:]' '[:lower:]' < tomsawyer.txt | tr -cs '[:alnum:]' '\n' | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}')
echo "The lower case transformation and word count are complete. The most frequent word is '$most_frequent_word'."


echo "11. Counting how often each word in the Whale book appear."
echo "The file is transferred to lowercase before counting unique words."
tr '[:upper:]' '[:lower:]' < thewhale.txt | tr -cs '[:alnum:]' '\n' | sort | uniq -c | sort -nr > word_count_thewhale.txt
echo "The word count has been saved to 'word_count_thewhale.txt'."

#get the 20 top frequent words for both 2 files
top20_tomsawyer=$(sort -nr word_count.txt | head -20 | awk '{print $2}')
top20_thewhale=$(sort -nr word_count_thewhale.txt | head -20 | awk '{print $2}')

# Find the words that are common to both lists
common_words=$(comm -12 <(echo "$top20_tomsawyer" | sort) <(echo "$top20_thewhale" | sort) | wc -l)

# Print the result
echo "The number of common words in the 20 most frequent words of each book is $common_words."

#file city tasks

echo "1. Creat a copy file of city.csv, original data is downloaded as city.csv"

cp city.csv citycopy.csv

echo " Copy is created"

echo "2.Exchange in the file all occurences of the Province "Amazonas" in Peru (Code PE)
with "Province of Amazonas""

echo " all occurences that has code PE is located and save in PE.csv, province amazonas is the third element seperate by comma"

grep ",PE," city.csv | sed 's/,Amazonas,/,Province of Amazonas,/g' > PE.csv

# Print the contents of PE.csv
echo "Cities in PE with 'Province of Amazonas':"
cat PE.csv


echo "3. Print all cities which have no population given."
awk -F, '$4 == "NULL" {print $1}' city.csv


echo "4. Print the line numbers of the cities in Great Britain (Code: GB)"
awk -F',' '$2 == "GB" {print NR}' city.csv


echo "5. Delete the records 5-12 and 31-34 from city.csv and store the result in city.2.csv"
sed '5,12d; 31,34d' city.csv > city.2.csv
echo "Records deleted successfully."

echo "6. Combine the used commands from the last two tasks and write a bash-script
(sequence of commands), which delete all british cities from the file city.csv"

# 6. Combine the used commands from the last two tasks and write a bash-script
# Delete all British cities from the file city.csv
sed "$(awk -F',' '$2 == "GB" {print NR"d"}' city.csv)" city.csv > city_without_gb.csv

echo "British cities deleted from city.csv, saved to city_without_gb.csv"







