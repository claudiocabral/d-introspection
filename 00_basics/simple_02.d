struct A(string name, bool dynamic = true, size_t size = 0) {
    // mixin allows you to compile arbitrary strings
    mixin("int " ~ name ~ ";");
    // if true, compile the next code block. Does not introduce a scope.
    static if (dynamic) {
        int[] buffer;
    } else {
        static assert(size != 0, "Please choose a buffer size");
        int[size] buffer;
    }
}

void main() {
    A!"nicholas" a;
    a.nicholas = 42;
    // A!("deniro", false) b;
}
