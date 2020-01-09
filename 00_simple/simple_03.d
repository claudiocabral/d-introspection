
struct struct_tag {}
enum enum_tag;

struct A {
    // types or values can be used as User Defined Attributes (UDA)
    int not_tagged;
    @struct_tag int tagged;
    @("value_tag") int also_tagged;
    @enum_tag int another_tagged;
}

void main() {
    // import anything, anywhere
    import std.stdio;
    // stanard libraries introspection utilites
    import std.traits;
    // unrolled for every value
    static foreach(member; A.tupleof) {
        static if(hasUDA!(member, struct_tag)) {
            member.stringof.writeln;
        }
    }
}
