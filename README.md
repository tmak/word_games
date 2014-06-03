# Welcome!

Please see the problem description and summary in `features/manage_mad_libs.feature`

# Getting Started

To get started with this rails app, you'll want to ensure you have the
correct version of ruby. You should be using MRI 1.9.3. We recommend
using [RVM][1], but use whatever method works best for you. This project
has a `.ruby-version` file included in it to help you get started.

After you have the proper version of ruby, you will need bundler (`gem
install bundler`), then you can run `bundle install` and get to work.

# Running the tests

You should be able to just run `cucumber` from the console and see the
tests run (and fail to start). Sometimes you might have to run `bundle
exec cucumber` depending on your particular environment.

`bundle exec cucumber -t ~@web; bundle exec cucumber -t @web; USE_JS_DRIVER=1 bundle exec cucumber -t @web`

# Goal

Make the tests pass. Good luck! :)

[1]: http://rvm.io
