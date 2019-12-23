import std.meta;
import std.traits;
import std.conv: to;
import std.format;

struct ignore {}

///
auto serialize(T, size_t indentation = 1)(const ref T t) {
    static if (hasMember!(T, "serialize")
            && isFunction!(t.serialize)
            && !hasUDA!(t.serialize, ignore)) {
        return t.serialize;
    } else static if (isNumeric!T || isPointer!T) {
        return t.to!string;
    } else static if (isSomeString!T) {
        return `"%s"`.format(t);
    } else static if (isArray!T) {
        auto res = "[ ";
        foreach (i, const ref member; t) {
            res ~= "%s, ".format(serialize!(typeof(member), indentation +
                        1)(member));
        }
        return res ~ "]";
    } else static if (isAssociativeArray!T) {
        enum char[indentation] prefix = '\t';
        auto res = "{\n";
        foreach (const ref key, const ref member; t) {
                res ~= "%s\"%s\": %s,\n".format(prefix, key,
                        serialize!(typeof(member), indentation + 1)(member));
        }
        return res ~ prefix[0..$-1] ~ "}";
    } else static if (isAggregateType!T) {
        enum char[indentation] prefix = '\t';
        auto res = "{\n";
        foreach (i, alias member; t.tupleof) {
            enum key = __traits(identifier, t.tupleof[i]);
            static if (!hasUDA!(t.tupleof[i], ignore)) {
                res ~= "%s\"%s\": %s,\n".format(prefix, key,
                        serialize!(typeof(member), indentation + 1)(member));
            }
        }
        return res ~ prefix[0..$-1] ~ "}";
    } else {
        enum type = typeof(t).stringof;
        static assert(false, "Can't serialize %s".format(type));
    }
}
