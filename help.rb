require 'faraday'
require 'oj'

return unless ARGV[0]

conn = Faraday.new(url: 'https://api.openai.com/v1/completions') do |c|
  c.request :authorization, 'Bearer', ENV['OPENAI_KEY']
end

begin
  resp = conn.post do |req|
    req.body = Oj.dump({model: 'text-davinci-003', prompt: ARGV.join(' ') + '?', temperature: 0, max_tokens: 256}, mode: :compat)
    req.headers["Content-Type"] = "application/json"
  end


  response = Oj.load(resp.body)
  puts response['choices'].first['text']
rescue => e
  puts "Error retrieving response: #{e}"
end
