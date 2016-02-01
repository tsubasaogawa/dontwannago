# coding: utf-8

# SEARCH_QUERY = "(学校 OR 仕事 OR 会社) 行きたくない"

class TwisController < ApplicationController
  def index
    @log = Logs.all
	# @chart_data = Logs.all.order('date').group(:date).sum(:count)
	@chart_data = Logs.select(:date, :count).limit(5).order(date: :desc).pluck(:date, :count)
  end
end
