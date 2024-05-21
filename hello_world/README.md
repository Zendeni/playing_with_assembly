# Assemble the source code into an object file
nasm -f elf64 -o helloWorld.o helloWorld.s

# Link the object file to create an executable
ld -o helloWorld helloWorld.o

# Run the executable
./helloWorld
