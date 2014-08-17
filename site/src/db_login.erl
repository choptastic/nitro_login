-module(db_login).
-export([
	create_account/2
]).

open_db() ->     
	Options = [{type,set}],
	{ok, logins} = dets:open_file(logins, Options). 

close_db() -> 
	ok = dets:close(logins).

create_account(Username, Password) ->
	open_db(),
	PWHash = erlpass:hash(Password),
	dets:insert(logins, {Username, PWHash}),
	close_db(),
	ok.
