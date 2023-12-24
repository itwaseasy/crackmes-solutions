package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

const LinesCount = 5
const BlocksCount = 264
const ElementSize = 6

var linesBitsFormat = [...][]string{
	{"100001", "110011"},
	{"001100", "100011"},
	{"001100", "110011"},
	{"001100", "110011"},
	{"100001", "000000"},
}

func main() {
	if len(os.Args) != 2 {
		fmt.Println("./powershelly [output_file]")
		os.Exit(1)
	}

	output, err := os.Open(os.Args[1])
	if err != nil {
		log.Fatal("can't open a file: ", err)
	}
	defer output.Close()

	seeds := generateSeeds()
	randoms := generateRandoms()

	scanner := bufio.NewScanner(output)
	result := int64(0)

	input := make([]strings.Builder, LinesCount)

	for i := int64(0); scanner.Scan(); i++ {
		number, err := strconv.ParseInt(scanner.Text(), 10, 64)
		if err != nil {
			log.Fatal("can't convert a number to int64: ", err)
		}

		revertedNumber := number ^ result ^ randoms[i]
		result = revertedNumber ^ result ^ randoms[i]

		unscrambled := unscramble(revertedNumber, seeds[i])
		for j := 0; j < len(input); j++ {
			input[j].WriteString(unscrambled[j*ElementSize : j*ElementSize+ElementSize])
			input[j].WriteByte(' ')
		}
	}

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}

	printLines(input)
}

func generateSeeds() []int64 {
	seeds := make([]int64, BlocksCount)

	for i := int64(1); i < BlocksCount+1; i++ {
		seeds[i-1] = (i * 127) % 500
	}

	return seeds
}

func generateRandoms() []int64 {
	randoms := make([]int64, BlocksCount)

	for i := int64(1); i < BlocksCount+1; i++ {
		randoms[i-1] = (((i * 327) % 681) + 344) % 313
	}

	return randoms
}

func unscramble(number int64, seed int64) string {
	bits := strconv.FormatInt(number, 2)
	markers := make([]byte, len(bits)/2)
	result := make([]byte, len(bits)/2)

	for i := range markers {
		markers[i] = '?'
	}

	resultLength := int64(len(result))
	for i := int64(0); i < resultLength; i++ {
		index := (i * seed) % resultLength
		for markers[index] != '?' {
			index = (index + 1) % resultLength
		}

		char := byte('?')
		if bits[2*index:2*index+2] == "11" {
			char = '1'
		} else {
			char = '0'
		}

		markers[index] = char
		result[i] = char
	}

	return string(result)
}

func printLines(lines []strings.Builder) {
	var lineResult strings.Builder

	for i := range linesBitsFormat {
		fmt.Printf("line %d: ", i+1)

		line := strings.Split(lines[i].String(), " ")
		for _, element := range line {
			if element == linesBitsFormat[i][0] {
				lineResult.WriteByte('0')
			} else {
				lineResult.WriteByte('1')
			}

			if lineResult.Len() == 8 {
				if char, err := strconv.ParseInt(lineResult.String(), 2, 8); err != nil {
					log.Fatal("can't convert flag's character: ", err)
				} else {
					fmt.Printf("%c", char)
				}

				lineResult.Reset()
			}
		}

		fmt.Println()
		lineResult.Reset()
	}
}
