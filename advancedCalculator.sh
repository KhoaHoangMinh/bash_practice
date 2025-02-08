#!/bin/bash

calculate() {	
	while true; do
	
		read -p ">> " num1 op num2
		if [ $num1 == "EXIT" ]; then
			break
		fi
		if [[ -f ~/.ans ]]; then
    			ANS=$(cat ~/.ans)
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
		echo "$ANS" > ~/.ans
		echo "$ANS"
		read -n 0 -s
		# -n 0: read 1 character, -s: silent mode
		clear
	done	
}

calculate
