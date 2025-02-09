#!/bin/bash

calculate() {	
	HISTORY_FILE=~/.calc_history
	ANS_FILE=~/.ans

	while true; do
		read -p ">> " num1 op num2

		if [[ $num1 == "EXIT" ]]; then
			break
		fi

		if [[ "$num1" == "HIST" ]]; then
			if [[ -f $HISTORY_FILE ]]; then
				cat $HISTORY_FILE
			else
				echo "No history"
			fi
			continue
		fi	

		# Load previous ANS value
		if [[ -f "$ANS_FILE" ]]; then
    			ANS=$(cat "$ANS_FILE")
		else
    			ANS=0
		fi

		if [[ "$num1" == "ANS" ]]; then
			num1=$ANS
		fi
		if [[ "$num2" == "ANS" ]]; then
			num2=$ANS
		fi	

	 	case $op in
		       	+)
			ANS=$(echo "scale=2; $num1 + $num2" | bc)
			;;

			-)
			ANS=$(echo "scale=2; $num1 - $num2" | bc)
			;;

			\*)
			ANS=$(echo "scale=2; $num1 * $num2" | bc)
			;;

			/)
			if [ $num2 == 0 ]; then
				echo "MATH ERROR"
			else
				ANS=$(echo "scale=2; $num1 / $num2" | bc)
			fi
			;;

			%)
			if [ $num2 == 0 ]; then
		       		echo "MATH ERROR"
	 	      	else
				ANS=$(($num1 / $num2))
	 		fi		
			;;

			*)
			echo "SYNTAX ERROR"
			break
			;;
		esac
		
		# Save answer
		echo "$ANS" > "$ANS_FILE"

		# Save history
		echo "$num1 $op $num2 = $ANS" >> $HISTORY_FILE
		tail -n 5 $HISTORY_FILE > $HISTORY_FILE.tmp && mv $HISTORY_FILE.tmp $HISTORY_FILE

		echo "$ANS"
		read -n 1 -s -r
		# -n 0: read 1 character, -s: silent mode
		clear
	done	
}

calculate
