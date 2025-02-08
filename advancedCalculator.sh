#!/bin/bash

calculate() {	
	while true; do
		ANS=0

		read -p ">> " num1 op num2
		if [ $num1 == "EXIT" ]; then
			break
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
		echo "$ANS"
		read -n 1 -s
		# -n 1: read 1 character, -s: silent mode
		clear
	done	
}

calculate
