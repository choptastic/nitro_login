-module(create_account).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").

main() -> #template{file="site/templates/bare.html"}.

title() -> "Create an account!".

is_username_available(_Tag, Username) ->
	not(db_login:username_exists(Username)).

body() ->
	wf:defer(save, username, #validate{validators=[
		#is_required{text="Username Required"},
		#custom{text="Username taken",
				function=fun is_username_available/2,
				tag=available}]}),
	wf:defer(save, password, #validate{validators=[
		#is_required{text="Password Required"}]}),
	wf:defer(save, password2, #validate{validators=[
		#confirm_same{text="Passwords do not match",
					  confirm_id=password}]}),
	[
		#label{text="Username"},
		#textbox{id=username},
		#label{text="Password"},
		#password{id=password},
		#label{text="Confirm Password"},
		#password{id=password2},
		#br{},
		#button{id=save, text="Save Account", postback=save}
   ].

event(save) ->
	[Username, Password] = wf:mq([username, password]),
  	ok = db_login:create_account(Username, Password),
  	wf:user(Username),
  	wf:redirect("/").
