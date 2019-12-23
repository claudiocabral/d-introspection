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

void main(string[] args) {
    http_handler handler;
    http_serve(handler, args);
}
