-module(create_account).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").

main() -> #template{file="site/templates/bare.html"}.

title() -> "Create an account!".

body() ->
	[
		#label{text="Username"},
		#textbox{id=username},
		#label{text="Password"},
		#password{id=password},
		#label{text="Confirm Password"},
		#password{id=password2},
		#br{},
		#button{text="Save Account", postback=save}
   ].

event(save) ->
	[Username, Password] = wf:mq([username, password]),
  	ok = db_login:create_account(Username, Password),
  	wf:user(Username),
  	wf:redirect("/").
