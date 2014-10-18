# coding: utf-8 #
SEARCH_QUERY = "(学校 OR 仕事 OR 会社) AND (行きたくない OR いきたくない) exclude:retweets"

task :get_twilog => :environment do
  puts 'Get tweets...'

  require "twitter"
  require "active_support/time"
	
  client = Twitter::REST::Client.new do |config|
    config.consumer_key = "0tvANBAfxBp718sb68ZvKjTYs"
    config.consumer_secret = "MRcqb97JHfEb546WWVleb9N5lABEIZFVmVyYut2o8PGeh3MaGc"
    config.access_token = "2862817016-cY8emrwwzZT7OUUsH8hSNuCzxfwNF3JHWwGKR2X"
    config.access_token_secret = "enrZFfi7x4woOQ1mrVVsYPChOKE4OujzbwlK8zoTZK2mz"
  end

  count = 0
  # total_followers_count = 0
  max_id = nil

  begin
    client.search(SEARCH_QUERY, lang: :ja, locale: :ja, max_id: max_id).each do |tweet|
      next if tweet.created_at >= 1.day.since.beginning_of_day

      if tweet.created_at < Time.now.beginning_of_day
        max_id = nil
        break
      end
      count += 1
      # total_followers_count += tweet.user.followers_count
      max_id = tweet.id
    end
	
  rescue Twitter::Error::TooManyRequests
    puts "rate limit."
	sleep 60*15
    retry

  rescue Twitter::Error::ClientError
    puts "Client error."
	break
	
  end while max_id != nil

  now = Date::today
  tweet = Log.new(:date => now, :count => count)
  tweet.save
  
  puts "Done. (#{$count} tweets)"
  
  # tweeting to my account
  client.update "#{now.month}月#{now.day}日の登校/出社拒否人数は  #{count} 人でした。"
end