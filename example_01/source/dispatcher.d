import callbacks;
import std.traits;

auto make_callback_table() {
    foreach (id; __traits(allMembers, callbacks)) {
        alias member = __traits(getMember, callbacks, id);
        static if (__traits(isStaticFunction, member)
                && is(typeof(&member) == callback)) {
            pragma(msg, __traits(identifier, member));
        }
    }
}
