package main

import (
	"fmt"
)

func main() {
	flag := []byte{
		0x7A, 0x2E, 0x6E, 0x68, 0x1D, 0x65, 0x16, 0x7C, 0x6D, 0x43,
		0x6F, 0x36, 0x3F, 0x62, 0x15, 0x46, 0x43, 0x36, 0x40, 0x37,
		0x58, 0x01, 0x58, 0x35, 0x62, 0x6B, 0x53, 0x30, 0x38, 0x17,
	}

	swapBytes(flag)

	for i := 0x0ABCF00D; i < 0xDEADBEEF; i += 2075469 {
		decryptBuffer(flag, i)
	}

	fmt.Println(string(flag))
}

func decryptBuffer(buffer []byte, xorConst int) {
	xorBytes := []byte{
		byte((xorConst >> 24) & 0xff),
		byte((xorConst >> 16) & 0xff),
		byte((xorConst >> 8) & 0xff),
		byte(xorConst & 0xff),
	}

	for i := 0; i < len(buffer); i++ {
		buffer[i] ^= xorBytes[i&3]
	}
}

func swapBytes(buffer []byte) {
	for i := len(buffer) - 1; i > 0; i-- {
		for j := 0; ; j += i {
			if j >= len(buffer)-i+1 {
				break
			}

			buffer[j], buffer[j+i-1] = buffer[j+i-1], buffer[j]
		}
	}
}
