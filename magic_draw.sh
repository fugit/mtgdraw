#!/bin/bash

### RANDOM HAND ###
# Script to play test magic cards
# Just to test a deck change not much of anything yet
#
#

### CONFIG ###
CARDS='60'   # How many cards in the deck 
DRAW="7"     # How many cards to draw
FILE="$1"    # The file containing the deck
card=''
lands=0
creature=0
instants=0
sourcery=0
### END CONFIG ###

### MAIN ###
# Come up with 7 random cards # 
# can't pick the same number twice
echo "Draw = $DRAW"
numcards='0'
until  [ "$numcards" = "$DRAW" ]; do 
	#echo "NUMBER OF CARDS = $numcards"
	until [ $real_card ] ; do
		tempcard=$((RANDOM%59 +1 ))
		#echo "CARD: $tempcard"
	    	for x in ${!card[@]} ; do 
			#echo "x:$x tempcard:$tempcard XCARDVALUE:${card[$x]} numcards:$numcards"
			#x:0 card:34 numcards:0
			if [ "$tempcard" = "${card[$x]}" ] && [ ${card[$x]} != 0  ] ; then 
				#echo "error"
				tempcard=$((RANDOM%59 +1 ))
				real_card=''
			else 
				card[$numcards]=$tempcard
				#echo "CARD: ${card[$numcards]}"
				real_card="${card[$numcards]}"
			fi 
		done
	done 
	real_card=''
	#echo "ARRAY:$numcards VALUE:${card[$numcards]}"
	cat -n  $FILE | egrep -w "${card[$numcards]}"
	card=$(cat -n  $FILE | egrep -w "${card[$numcards]}")
	if [[ $card == *"#land"* ]] ; then 
		#echo land
		((land++))
	fi
	if [[ $card == *"#creature"* ]] ; then 
		#echo creature
		((creature++))
	fi
	if [[ $card == *"#sourcery"* ]] ; then 
		#echo sourcery
		((sourcery++))
	fi
	if [[ $card == *"#instant"* ]] ; then 
		#echo instant
		((instant++))
	fi
	numcards=$(( $numcards + 1 ))
done 

echo "LANDS: $land"
echo "CREATURES: $creature"
echo "SOURCERY: $sourcery"
echo "INSTANT: $instant"
exit
