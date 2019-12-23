import std.stdio;
import std.traits;
import std.meta;

struct on_request {
    string route = "";
}

alias IsRequestHandler(alias T) = hasUDA!(T, on_request); 

void http_serve(T)(ref T t, string[] args) {
    foreach (ref arg; args) {
dispatch: switch (arg) {
            static foreach(id; __traits(allMembers, T)) {{
                alias member = __traits(getMember, T, id);
                static if(IsRequestHandler!member) {
                    alias request_params = getUDAs!(member, on_request);
                    alias request_param = Alias!(request_params[0]);
                    static if (!is(request_param == on_request)
                            && request_param.route != ""
                            && request_param.route != "default"
                            ) {
                        case(request_param.route):
                    } else {
                        case(id):
                    }
                    mixin("t." ~ id ~ "();");
                    break dispatch;
                }
            }}
            default:
            alias fallback = getSymbolsByUDA!(T, on_request("default"));
            static if (fallback.length > 0) {
                static assert(fallback.length == 1,
                        "Can't have more then one default");
                    fallback[0](t);
            }
            break;
        }
    }
}
