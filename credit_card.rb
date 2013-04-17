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
  validates :csv_format


  private 

    def csv_format
      errors.add(:csv, 'CSV length must be 3 or 4') unless [3,4].include? self.csv.length 
      errors.add(:csv, 'CSV must be numeric') if self.csv.to_i == 0
    end
    def card_type_accepted
      errors.add(:card_type, 'We only accept visa and amex') unless ['visa','amex'].include? self.card_type
    end

    def cc_num_format
      errors.add(:cc_num, 'Invalid number of characters.') if self.cc_num.length != 16
      errors.add(:cc_num, 'Credit Card number should not contain non-numerics') if self.cc_num.to_i == 0
    end
end