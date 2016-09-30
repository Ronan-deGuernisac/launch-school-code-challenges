# READ ME

One of the Weekly code challenges from the [Launch School](https://launchschool.com/) curriculum

---

### Secret Handshake

---

Write a program that will take a decimal number, and convert it to the appropriate sequence of events for a secret handshake.

There are 10 types of people in the world: Those who understand binary, and those who don't. You and your fellow cohort of those in the "know" when it comes to binary decide to come up with a secret "handshake".

```ruby
1 = wink
10 = double blink
100 = close your eyes
1000 = jump

10000 = Reverse the order of the operations in the secret handshake.
```

```ruby
handshake = SecretHandshake.new 9
handshake.commands # => ["wink","jump"]

handshake = SecretHandshake.new "11001"
handshake.commands # => ["jump","wink"]
---

Files in this directory:

* README.md (*problem description*)
* secret_handshake.rb (*solution*)
* secret_handshake_test.rb (*test suite*)
