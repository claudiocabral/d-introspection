import std.stdio;
import serial;

struct A {
    int a;
    B b;
    string str = "halloj";
    int [string] values;
    int *abc;
}

struct B {
    C[10] c;
}

struct C {
    float hejsa = 3.14;
    string robert = "hello world";
    int[] ages = [ 0, 1, 2, 3, 4];
    void func() {
    }
    auto serialize() const {
        return ages.serialize;
    }
}

void main()
{
    A a;
    a.values = [
        "this": 1,
        "that": 2,
        ];
    printf("%s\n", a.serialize.ptr);
}
