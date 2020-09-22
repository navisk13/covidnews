#!/bin/bash

curl https://www.who.int/emergencies/diseases/novel-coronavirus-2019/events-as-they-happen > news.txt
cat news.txt | grep "<h2>" |  grep -oP '(?<=h2).*?(?=h2)' | sed -e 's/nbsp//g' | sed -e 's/strong//g' | sed -e 's/ldquo//g' | sed -e 's/rdquo//g' | sed -e 's/rsquo//g' | tr -d '<>&;/"' |grep -v "span" | grep -v "style" | grep "\S" | head -n 3 > filtered.txt
latest=$(cat filtered.txt)
notify-send -t 5000 "$latest"

curl https://www.worldometers.info/coronavirus/ > count.txt
total=$(cat count.txt | grep -A1 "maincounter-number" | grep -v "maincounter-number" | grep -o -P '(?<=\>).*?(?=\<)' | sed -n '1p')
deaths=$(cat count.txt | grep -A1 "maincounter-number" | grep -v "maincounter-number" | grep -o -P '(?<=\>).*?(?=\<)' | sed -n '2p') 
recovered=$(cat count.txt | grep -A1 "maincounter-number" | grep -v "maincounter-number" | grep -o -P '(?<=\>).*?(?=\<)' | sed -n '3p')
notify-send -t 5000 "Total Cases:$total"
notify-send -t 5000 "Deaths:$deaths"
notify-send -t 5000 "Recovered:$recovered" 
