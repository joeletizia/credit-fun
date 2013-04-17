Credit Card Encryptor
==========

A little fun with encryption.

I created a small class that acts as a rudimentary credit card encryptor. Call #encrypt on a CreditCard object, and a cipher text string will be returned. The card is encrypted with 1024 bit RSA encryption. 

The method #decrypt is a static method that takes a hash and a key (the private key used to create the credit card) and parses the resulting hash. 
