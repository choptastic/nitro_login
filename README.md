# nitro_login


A sample app demonstrating logging in and out with the [Nitrogen Web Framework](http://nitrogenproject.com) using Bcrypt. This project is used as a demonstration chapter in work-in-progress book "Build it with Nitrogen: The fast-off-the-block Erlang web framework" by Jesse Gumm and Lloyd R. Prentice.

To try this app out, you must already have Erlang installed (preferably Erlang 17).

```bash
git clone git://github.com/choptastic/nitro_login
cd nitro_login
make fix-slim-release # only if you a version of Erlang other than 17 installed
make
bin/nitrogen console
```

Then open your browser to http://127.0.0.1:8000

# License

All code is MIT Licensed, Copyright 2014 Jesse Gumm
