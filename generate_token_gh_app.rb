#!/usr/bin/ruby

require 'openssl'
require 'jwt'  # https://rubygems.org/gems/jwt

# Private key contents
pem = File.read("GHE.pem")
#private_pem = File.read("pem")
private_key = OpenSSL::PKey::RSA.new(pem)

# Generate the JWT
payload = {
  # issued at time
  iat: Time.now.to_i,
  # JWT expiration time (10 minute maximum)
  exp: Time.now.to_i + (10 * 60),
  # GitHub App's identifier
  iss: 61967
}

jwt = JWT.encode(payload, private_key, "RS256")
File.open("jwt.txt", "w")
File.write("jwt.txt", jwt)
puts jwt
