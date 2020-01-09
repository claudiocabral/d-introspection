/// struct template declaration
struct A(T) {
    T t;
}

/// almost anything can be used as a template parameter
struct A(string parameter) {
}

void main() {
    A!"nicholas" a;
    A!"cage" b;

    // creates an alias for a symbol
    alias nicholas_type = A!"nicholas";
    nicholas_type c;

    // like C++
    static assert(!is(typeof(a) == typeof(b)));
    static assert(is(typeof(a) == typeof(c)));

    // compiler directives, msg prints a value at compile time
    pragma(msg, typeof(a));
}
