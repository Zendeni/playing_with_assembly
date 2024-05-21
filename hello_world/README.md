# Assemble the source code into an object file
nasm -f elf64 -o helloWorld.o helloWorld.s

# Link the object file to create an executable
ld -o helloWorld helloWorld.o

# Run the executable
./helloWorld


## Or use this bash script
usage
```
./assembler.sh helloWorld.s
```
```
#!/bin/bash

fileName="${1%%.*}" # remove .s extension

nasm -f elf64 ${fileName}".s"
ld ${fileName}".o" -o ${fileName}
[ "$2" == "-g" ] && gdb -q ${fileName} || ./${fileName}
```
