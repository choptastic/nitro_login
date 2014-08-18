-module(db_login).
-export([
	create_account/2,
	attempt_login/2,
	username_exists/1
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

attempt_login(Username, Password) ->
	open_db(),
	Result = case dets:lookup(logins, Username) of
		[] -> false;
		[{_, PWHash}] ->
			erlpass:match(Password, PWHash)
	end,
	close_db(),
	Result.

username_exists(Username) ->
	open_db(),
	Exists = case dets:lookup(logins, Username) of
		[] -> false;
		_ -> true
	end,
	close_db(),
	Exists.

