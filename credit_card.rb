require 'active_record'
require 'gibberish'
require 'validates_timeliness'

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
      table.column :private_key, :string
      table.column :public_key, :string
    end
end

class CreditCard < ActiveRecord::Base
  attr_accessor :cc_num, :csv, :expiration, :card_type, :private_key, :public_key

  validate :cc_num_format
  validate :card_type_accepted
  validate :csv_format
  validates_date :expiration


  def initialize
    k = Gibberish::RSA.generate_keypair(1024)
    self.public_key = k.public_key
    self.private_key = k.private_key
  end

  def encrypt
    cipher = Gibberish::RSA.new(self.public_key)
    cipher.encrypt(self.to_s)
  end

  def self.decrypt(hash, key)
    cipher = Gibberish::RSA.new(key)
    CreditCard.from_hash(cipher.decrypt(hash))
  end

  def to_s
    "#{self.cc_num} #{self.csv} #{self.expiration.strftime "%m"}-#{self.expiration.strftime "%y"} #{self.card_type}"
  end

  def self.from_hash(hash)
    vals = hash.split " "

    new_card = CreditCard.new

    new_card.cc_num = vals[0]
    new_card.csv = vals[1]
    new_card.expiration = Date.strptime "#{vals[2]}", "%m-%y"
    new_card.card_type = vals[3]

    new_card      
  end 

  private
    def csv_format
      errors.add(:csv, 'CSV length must be 3 or 4') unless [3,4].include? self.csv.length 
      errors.add(:csv, 'CSV must be numeric') if self.csv.to_i == 0
    end
    def card_type_accepted
      errors.add(:card_type, 'We only accept visa and amex') unless ['visa','mastercard','amex'].include? self.card_type
    end

    def cc_num_format
      errors.add(:cc_num, 'Invalid number of characters.') if self.cc_num.length != 16
      errors.add(:cc_num, 'Credit Card number should not contain non-numerics') if self.cc_num.to_i == 0
    end
end