// metaprogramming tools:

void main () {
    // functions via Compile Time Function Evaluation (everything is constexpr)
    auto func(string name) { return "int " ~ name ~ ";"; }

    // enums are type qualifiers that make a variable available at compile time
    enum available_at_compile_time = func("bob");

    // __traits, the big hammer that lets you query all sorts of things
    enum canCompile = __traits(compiles, available_at_compile_time);

    // std templates that complmement or facilitate using __traits
    import std.traits;
    enum isFunc = isFunction!func;

    // pragma(msg) for debugging
    pragma(msg, canCompile);

    // static if
    static if (canCompile) {
        // mixins
        mixin(available_at_compile_time);
    }
    // UDAs
    struct tag {}

    // templates 
    struct A(T) {
        @tag T t;
    }

    // aliasing anything;
    alias MyInt = A!int;

    // compile time lists and loops
    struct Generated(Args...) {
        static foreach (i, alias arg; Args) {
            import std.conv: to;
            mixin(arg.stringof ~ " member" ~ i.to!string ~ ";");
        }
    }

    alias MyType = Generated!(int, string, float, void *, long, ulong);
    MyType list;

    // access type as tuple and combine everything!
    static foreach (alias member; MyType.tupleof) {
        static if (isIntegral!(typeof(member))) {
            import std.stdio;
            writeln(member.stringof ~ " is an integral type");
        }
    }
}
