# arreq
require 'active_record'
require 'pry'
require 'pg'
require_relative 'contact'
require_relative 'number'

# arlog
ActiveRecord::Base.logger = Logger.new(STDOUT)

# arconn
ActiveRecord::Base.establish_connection(
  host: 'localhost',
  adapter: 'postgresql',
  database: 'contact_list_v2',
  user: 'development',
  password: 'development'
)

# arconn
if !(ActiveRecord::Base.connection.table_exists? 'contact_list_v2')
  ActiveRecord::Schema.define do
    create_table :contacts, force: true do |t|
      t.string :name
      t.string :email
    end

    create_table :numbers, force: true do |t|
      t.string :number
      t.belongs_to :contact
    end
  end
end

puts 'Setup DONE'
