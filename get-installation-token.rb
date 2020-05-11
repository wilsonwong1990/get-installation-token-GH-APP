#!/usr/bin/ruby

require 'openssl'
require 'jwt'  # https://rubygems.org/gems/jwt
require 'net/http'
require 'uri'

puts "Where is the GitHub App certificate? (.pem format)"
pem_path = gets.chomp

puts "What is the installation id?"
installation_id = gets.chomp 

puts "What is the app identifier id?"
iss = gets.chomp


# Private key contents
pem = File.read("#{pem_path}")
#private_pem = File.read("pem")
private_key = OpenSSL::PKey::RSA.new(pem)

# Generate the JWT
payload = {
  # issued at time
  iat: Time.now.to_i,
  # JWT expiration time (10 minute maximum)
  exp: Time.now.to_i + (10 * 60),
  # GitHub App's identifier
  iss: iss
}

jwt = JWT.encode(payload, private_key, "RS256")

uri = URI.parse("https://api.github.com/app/installations/#{installation_id}/access_tokens")

request = Net::HTTP::Post.new(uri)
request["Authorization"] = "Bearer #{jwt}"
request["Accept"] = "application/vnd.github.machine-man-preview+json"

req_options = {
  use_ssl: uri.scheme == "https",
}

response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  http.request(request)
end
puts response.body
