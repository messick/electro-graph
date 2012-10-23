electro-graph
=============

Data visualization for electric car statistics.

1. brew install mongodb | sudo apt-get install mongodb
1. git clone git@github.com:messick/electro-graph
1. rvm install ruby-1.9.3 <-- this step may not be necessary
1. cd electro-graph
1. bundle install

Dummy Data Insert
-----------------

1. MONGOID_ENV=development ruby data_insert.rb

App Server Start
----------------

1. ruby app.rb

Goto following URL: http://127.0.0.1:4567