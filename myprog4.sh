#!/bin/bash

if [ -z "$1" ]
then
# Prompts the codes usage 
    echo "Usage of the program is: $0 <int>"
    exit 1
fi

limit=$1

# Method for checking the number is prime or not
isPrime() {
    number=$1
    for (( i=2; i*i<=number; i++ ))
    do
        if (( number % i == 0 ))
        then
            return 1  
        fi
    done
    return 0  
}

for (( n=2; n<limit; n++ ))
do
# Finds the prime numbers less than the input number
    if isPrime "$n"
    then
        num=$n
        hex=""
        
# Writes the number in hexadecimal form
        while [ "$num" -gt 0 ]
        do
            remainder=$((num % 16))

            if [ "$remainder" -lt 10 ]
            then
                hex_char=$(printf "\x$(printf %x $((48 + remainder)))")
            else
                hex_char=$(printf "\x$(printf %x $((55 + remainder)))")
            fi

            hex="$hex_char$hex"
            num=$((num / 16))
        done
        
        if [ -z "$hex" ]
        then
            hex="0"
        fi
        echo "Hexadecimal of $n is $hex"
    fi
done
