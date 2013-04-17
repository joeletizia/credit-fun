require './credit_card.rb'

puts "Loaded successfully"

x = CreditCard.new

x.cc_num = '1234567890123456'
x.csv = '123'
x.expiration = Date.today
x.card_type = 'visa'

# puts "Private Key is #{x.private_key}"
# puts "Public Key is #{x.public_key}"

ret = CreditCard.decrypt(x.encrypt, x.private_key)

puts "Ret is #{ret}"

puts (x.cc_num === ret.cc_num ? 'It worked' : "failed, got #{ret}")

x = CreditCard.new 

x.cc_num = '8837465837654987'
x.csv = '443'
x.expiration = Date.today - 88
x.card_type = 'mastercard'

ret = CreditCard.decrypt(x.encrypt, x.private_key)

puts "Ret is #{ret}"

puts (x.cc_num === ret.cc_num ? 'It worked' : "failed, got #{ret}")
