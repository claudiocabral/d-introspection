// function declaration:
int add(int a, int b) {
    return a + b;
}

// every program starts calling the main function
void main() {
    // available types:
    int a = -10;
    real pi = 3.14;
    char c = 'a';
    string c = "hello"; // a string of characters

    // those types have variations
    uint d = 10; // integers from 0 to uint.max;
    float e; // the smallest representation of real (32 bits)

    // types let you detect errors before you run the program
    // add(a, e); // fails
}
