require 'sequel'
DB = Sequel.connect(adapter: 'mysql2', database: 'mangarbDev', host: 'localhost', user: 'mangarb')
