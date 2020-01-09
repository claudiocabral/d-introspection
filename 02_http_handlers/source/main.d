import core.stdc.string;
import core.stdc.stdlib;

import std.stdio;

import lib;

struct http_handler {
    @nogc:
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
        "unknown request\n".printf;
    }
}

@nogc void app(string[] args) {
    http_handler handler;
    http_serve(handler, args);
}

version(D_BetterC) {
    @nogc extern(C) int main(int argc, char **argv) {
        auto size = argc - 1;
        void * args_buffer = malloc((string[]).sizeof * size);
        string[] args = (cast(string *)args_buffer)[0..size];
        foreach(i; 1 .. argc) {
            auto len = strlen(argv[i]);
            args[i - 1] = cast(string)argv[i][0..len];
        }
        app(args);
        free(args_buffer);
        return 0;
    }
} else {
    void main(string[] args) {
        app(args[1..$]);
    }
}
