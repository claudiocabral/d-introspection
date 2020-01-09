void main() {
    long a;
    // make queries about types
    enum isInt = __traits(isIntegral, a);
    pragma(msg, isInt);

    struct A {
        int member1;
        float member2;
        long member3;
    }
    st
}
