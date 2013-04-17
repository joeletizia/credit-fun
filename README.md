Credit Card Encryptor
==========

A little fun with encryption.

I created a small class that acts as a rudimentary credit card encryptor. Call #encrypt on a CreditCard object, and a cipher text string will be returned. The card is encrypted with 1024 bit RSA encryption. 

The method #decrypt is a static method that takes a hash and a key (the private key used to create the credit card) and parses the resulting hash. 


### How it works

Install the following gems:
````bash
gem install gibberish # for encryption
gem validates_timeliness # for date validation
````
Run the test suite

````bash
joeletizia$ ruby credit_card_test.rb
-- create_table(:credit_cards)
   -> 0.0074s
Loaded successfully
Decrypted: 1234567890123456 123 DYKVWTVW 04-13 visa
It worked
Decrypted: 8837465837654987 443 KWERUUBC 01-13 mastercard
It worked
````
