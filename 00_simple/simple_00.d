/// template declaration
void func(T)(T t) {
}

/// template specialization
void func(T:int)(T t) {
}

/// template predicates similar to concepts
void func(T)(T t) if (is(T == float)) {}

/// main function can be declared void
void main() {
    int a;
    // Instantiate a template with operator !
    func!(int)(a);
    // parenthesis can be ommited for 1 parameter
    func!int(a);
    // templates can be deduced
    func(a);
    // you can call anything like a method
    a.func;
}
