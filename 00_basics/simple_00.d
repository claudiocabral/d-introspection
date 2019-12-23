/// template declaration
void func(T)(T t) {
}

/// template specialization
void func(T:int)(T t) {
}

/// template predicates similar to concepts
void func(T)(T t) if (is(T == float)) {
}

/// main function can be declared void
void main() {
    // template parameters are deduced
    int a;
    func(a);
    // but can be explicitly instantiated with !
    string b;
    func!(string)(b);
    // parenthesis can be ommited for 1 parameter
    func!string(b);
}
