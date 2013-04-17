require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database =>  ':memory:'
)

ActiveRecord::Schema.define do
    create_table :credit_cards do |table|
      table.column :cc_num, :integer
      table.column :csv, :integer
      table.column :expiration, :date 
      table.column :card_type, :string
    end
end



class CreditCard < ActiveRecord::Base
  attr_accessor :cc_num, :csv, :expiration, :card_type

  validates :cc_num, :numericality => {:only_integer => true}
end