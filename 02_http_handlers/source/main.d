import std.stdio;
import lib;

struct http_handler {
    @on_request void items() {
        "send items".writeln;
    }
    @on_request void users() {
        "send users".writeln;
    }
    @on_request("/better_name") void BadNameForACallBack() {
        "send something else".writeln;
    }
    @on_request("default") void fallback() {
        "unknown request".writeln;
    }
}

void main(string[] args) {
    http_handler handler;
    http_serve(handler, args);
}
