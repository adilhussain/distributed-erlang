-module(client_tcp).
-export([send/3]).

send(Host, Port, Request) ->
    {ok, Socket} = gen_tcp:connect(Host, Port, [binary, {packet, 0}]),
    ok = gen_tcp:send(Socket, Request),
    io:format("CLIENT Sent: ~p\n", [Request]),
    receive
        {tcp, Socket, Bin} ->
            io:format("CLIENT Received: ~p\n", [Bin]),
            gen_tcp:close(Socket)
    end.
