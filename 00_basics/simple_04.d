import std.traits;

struct complex_tag {
    string value;
    alias value this;
}

struct A {
    @complex_tag("foo") int tagged;
    @complex_tag("bar") int tagged_too;
}

void main() {
    // use double brackets to introduce scope
    static foreach(member; A.tupleof) {{
        alias tags = getUDAs!(member, complex_tag);
        static assert(tags.length == 1, "Multiple complex_tags not allowed");
        // like a C #define macro
        enum tag = tags[0];
        static if (tag == "foo") {
            pragma(msg, "found foo");
        }
    }}
}
