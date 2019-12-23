import std.traits;

struct simple_tag {}

struct A {
    // types or values can be used as User Defined Attributes (UDA)
    @simple_tag int tagged;
    int not_tagged;
}

void main() {
    // unrolled for every value
    static foreach(member; A.tupleof) {
        static if(hasUDA!(member, simple_tag)) {
            pragma(msg, member.stringof);
        }
    }
}
