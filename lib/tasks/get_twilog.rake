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

  # save to db
  now = Date::today
  tweet = Log.new(:date => now, :count => count)
  tweet.save
  
  # calculate deviation
  mean = Logs.average(:count)
  variance = 0.0
  n = 0
  Logs.find_each do |data|
    variance += data.count * data.count
    n += 1
  end
  variance = (variance / n) - (mean * mean)
  deviation = (count - mean) / (variance ** 0.5) * 10 + 50

  puts "Done. (#{count} tweets; deviation: #{deviation.round})"

  client.update "#{now.month}月#{now.day}日の学校や会社に行きたくない人は #{count} 人いました。 (偏差値: #{deviation.round})"
end
