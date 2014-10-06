# coding: utf-8 #
SEARCH_QUERY = "(学校 OR 仕事 OR 会社) AND (行きたくない OR いきたくない) exclude:retweets"

task :get_twilog => :environment do
  puts 'Get tweets...'

  require "twitter"
  require "active_support/time"
	
  client = Twitter::REST::Client.new do |config|
    config.consumer_key = "ODk1GGV887Qu7Z3jc18a8vANe"
    config.consumer_secret = "JxRZTi495046uCFPZIchVOKEV5tVX1YbCBNPBTvinYX1fWwlqn"
    config.access_token = "139367557-EIkUKXKP7yKLHsVZkjAclLhaInlVLkgequbnUhK8"
    config.access_token_secret = "GFDCEbn5e8S65Id7tM5No6lxGwx0PzgSKNvIjKJ1clqQQ"
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
  end while max_id != nil

  now = Date::today
  tweet = Log.new(:date => now, :count => count)
  tweet.save
  
  puts "Done. (#{$count} tweets)"
end