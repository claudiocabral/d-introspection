import std.stdio;
import lib;

struct http_handler {
    @on_request void items() {
        "send items\n".printf;
    }
    @on_request void users() {
        "send users\n".printf;
    }
    @on_request("/better_name") void BadNameForACallBack() {
        "send something else\n".printf;
    }
    @on_request("default") void fallback() {
    }
}

version(D_BetterC) {
    extern(C) int main(int argc, char **argv) {
        http_handler handler;
        http_serve(handler, argc, argv);
        return 0;
    }
}
