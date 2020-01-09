import std.stdio;

// eponymous template block. Similar to a struct, but doens't create type
template Template(T) {
    T internal = 1;
    T func() {
        return internal;
    }
}

// mixin template lets you inject statements in a scope
mixin template TemplateMixin(T) {
    T injected = 42;
}

void main() {
    alias access = Template!int;
    static assert(is(typeof(access) == void));
    mixin TemplateMixin!int;
    injected = access.func();
    injected.writeln;
}
