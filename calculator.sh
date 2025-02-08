#!/bin/bash
calculate() {
	read -p "Enter a: " a
	read -p "Enter b: " b

	echo "Enter arithmetic: "
	echo "1. Addition"
	echo "2. Subtraction"
	echo "3. Multiplication"
	echo "4. Division"
	
	read ch

	case "$ch" in

		1)res=$(echo "$a + $b" | bc)
		;;
		2)res=$(echo "$a - $b" | bc)
		;;
		3)res=$(echo "scale=4; $a * $b" | bc)
		;;
		4)
		if [ "$b" == "0" ]; then
			echo "Error: division by 0"
		else
			res=$(echo "scale=4; $a / $b" | bc)
		fi
		;;
	esac
	echo "Result: $res"
}
calculate
