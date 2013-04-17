require './credit_card.rb'

puts "Loaded successfully"

x = CreditCard.new

x.cc_num = '1234567890123456'
x.csv = '123'
x.expiration = Date.today
x.card_type = 'visa'

puts "Private Key is #{x.private_key}"
puts "Public Key is #{x.public_key}"

ret = CreditCard.decrypt(x.encrypt, x.private_key)

puts (x.to_s === ret ? 'It worked' : "failed, got #{ret}")