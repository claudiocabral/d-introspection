/// struct template declaration
struct A(T) {
    T t;
}

/// almost anything can be used as a template parameter
struct A(string parameter) {
}

void main() {
    // parenthesis can be ommited
    A!"nicholas" a;
    A!"cage" b;
    // creates an alias for a symbol
    alias nicholas_type = A!"nicholas";
    nicholas_type c;
    static assert(!is(typeof(a) == typeof(b)));
    static assert(is(typeof(a) == typeof(c)));
    pragma(msg, typeof(a));
}
