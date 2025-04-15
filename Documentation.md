
**CMPE 230**

**HW2**

**2022400366**

**2016400396**

**Spring 2024**

**Purpose**  
The project aims to create a program that gets a postfix expression as an input and creates the corresponding machine code outputs in RISC-V Assembly format. The program gets the input tokens that are separated by a bank character with a maximum total length of 256 characters. We assumed that the provided expression is syntactically correct and that all values and results are at most 12 bits(signed representation). The program assumes that the input integers are positive. On the other hand, the results of calculations can be negative.

**Design and Implementation**

The GNU Assembler language is used for this project. In the implementation of the project, the first part is creating an input buffer and getting the input. After that, the program reads the string input and puts the corresponding integer values in the stack until we get an operator as input.

After running into an operator, the program jumps to the relevant function and makes necessary calculations. During this part, the program prints the corresponding outputs. In addition, the program also pushes the result to the stack for future calculations.

To store and print the corresponding machine code outputs, we declare and initialize a set of strings. All strings except, “bin_str” are always used with their initial values. On the other hand, “bin_str” is used to store the 12-bit representation of the printed number in the code. For each output, it is revised and created accordingly.

To create the binary string, the program first checks whether a number is negative. If the figure is negative, it creates the two's complement representation. If not, the code directly creates the binary representation without the two's complement transformation.

**Challenges**

The main challenge was to understand and get familiarized with the GNU Assembler as a whole. After fully understanding the structure and familiarizing myself with the GDB debugging tool the rest of the project became easier to implement.

The second challenge worth mentioning was to deal with the negative numbers. To solve this issue, we used a set of functions to calculate the 2`s complement representation of the string.

The last challenge in the implementation was creating the leading zeros (zero characters before the initial 1) in the binary representation. To solve this issue, we created an initialized string (bin_str) and used this string in the calculations.

**Usage of the program and Examples of Input/Output**

The program starts with the _“./postfix_translator_” command in the terminal. The user will enter the inputs and receive the outputs from the terminal.

The project has a MakeFile file that will automatically update the _postfix_translator_ file as the linked files are updated.

Below you can find the sample execution:

    $ make
    $ ./postfix_translator

Below you can find some examples of expected inputs and outputs of the program.

**EXAMPLE 1**

    Input: 
    2 3 + 4 5 + *
    Output: 
    000000101111 00000 000 00010 0010011
    000001001110 00000 000 00001 0010011
    0000000 00010 00001 000 00001 0110011
    000000000111 00000 000 00010 0010011
    000000001001 00000 000 00001 0010011
    0100000 00010 00001 000 00001 0110011
    000000000010 00000 000 00010 0010011
    000001111101 00000 000 00001 0010011
    0000001 00010 00001 000 00001 0110011
**EXAMPLE 2**

    Input: 
    333 100 125 & ^ 123 |
    Output: 
    000001111101 00000 000 00010 0010011
    000001100100 00000 000 00001 0010011
    0000111 00010 00001 000 00001 0110011
    000001100100 00000 000 00010 0010011
    000101001101 00000 000 00001 0010011
    0000100 00010 00001 000 00001 0110011
    000001111011 00000 000 00010 0010011
    000100101001 00000 000 00001 0010011
    0000110 00010 00001 000 00001 0110011
**EXAMPLE 3**

    Input: 
    2 3 4 + * 111 | 348 456 ^ & 5 1 - + 212 | 5 8 9 | +
    Output: 
    000000000100 00000 000 00010 0010011
    000000000011 00000 000 00001 0010011
    0000000 00010 00001 000 00001 0110011
    000000000111 00000 000 00010 0010011
    000000000010 00000 000 00001 0010011
    0000001 00010 00001 000 00001 0110011
    000001101111 00000 000 00010 0010011
    000000001110 00000 000 00001 0010011
    0000110 00010 00001 000 00001 0110011
    000111001000 00000 000 00010 0010011
    000101011100 00000 000 00001 0010011
    0000100 00010 00001 000 00001 0110011
    000010010100 00000 000 00010 0010011
    000001101111 00000 000 00001 0010011
    0000111 00010 00001 000 00001 0110011
    000000000001 00000 000 00010 0010011
    000000000101 00000 000 00001 0010011
    0100000 00010 00001 000 00001 0110011
    000000000100 00000 000 00010 0010011
    000000000100 00000 000 00001 0010011
    0000000 00010 00001 000 00001 0110011
    000011010100 00000 000 00010 0010011
    000000001000 00000 000 00001 0010011
    0000110 00010 00001 000 00001 0110011
    000000001001 00000 000 00010 0010011
    000000001000 00000 000 00001 0010011
    0000110 00010 00001 000 00001 0110011
    000000001001 00000 000 00010 0010011
    000000000101 00000 000 00001 0010011
    0000000 00010 00001 000 00001 0110011


    

