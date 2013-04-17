require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database =>  ':memory:'
)

ActiveRecord::Schema.define do
    create_table :credit_cards do |table|
      table.column :cc_num, :string
      table.column :csv, :string
      table.column :expiration, :date 
      table.column :card_type, :string
    end
end



class CreditCard < ActiveRecord::Base
  attr_accessor :cc_num, :csv, :expiration, :card_type

  validates :cc_num_format
  validates :card_type_accepted


  private 

    def card_type_accepted
      errors.add(:card_type, 'We only accept visa and amex') unless ['visa','amex'].include? :card_type
    end

    def cc_num_format
      if self.cc_num.length != 16
        errors.add(:cc_num, 'Invalid number of characters.')
      end

      self.cc_num.split("").each do |char|
        unless char =~ /[[:digit:]]/
          errors.add(:cc_num, 'Credit Card number should not contain non-numerics')
          break  
        end
      end
      
    end
end