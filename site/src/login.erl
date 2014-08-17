-module(login).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").

main() -> #template{file="site/templates/bare.html"}.

title() -> "Log In".

body() -> 
    wf:defer(login, username, #validate{validators=[
		#is_required{text="Username Required"}]}),
    wf:defer(login, password, #validate{validators=[
		#is_required{text="Password Required"}]}),
	[
	 	#label{text="Username"},
		#textbox{id=username},
		#label{text="Password"},
		#password{id=password},
		#br{}, 
	 	#button{id=login, text="Log In", postback=login}
  	].

event(login) ->
	[Username, Password] = wf:mq([username, password]),
	case db_login:attempt_login(Username, Password) of
		true ->
			wf:user(Username),
			wf:redirect("/");
		false ->
			wf:wire(#alert{text="Invalid Username or Password"})
	end.
