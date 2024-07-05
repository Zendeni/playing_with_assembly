# Simple HTTP Server in Assembly

This project is a simple HTTP server written in x86 assembly using NASM. The server listens on port 8080 and responds with a basic HTML page that says "Hello, World!".

## Prerequisites

- NASM (Netwide Assembler)
- A linker (e.g., ld)
- A Linux environment (or an appropriate setup to run x86 assembly code)

## Getting Started

### Installation

Ensure you have NASM and a linker installed. On Ubuntu, you can install them using:

```sh
sudo apt-get update
sudo apt-get install nasm
sudo apt-get install binutils
```
## Compilation and Execution
Clone the repository or download the http_server.asm file.

Open a terminal and navigate to the directory containing http_server.asm.

Compile the assembly code and link it:
```
nasm -f elf32 http_server.asm -o http_server.o
ld -m elf_i386 http_server.o -o http_server
```
Run the server (you might need sudo to bind to port 8080):
```
sudo ./http_server
```
## Testing
Open a web browser and navigate to http://localhost:8080. You should see the following message:\
Hello, World!
