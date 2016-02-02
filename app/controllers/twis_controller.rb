# coding: utf-8

# SEARCH_QUERY = "(学校 OR 仕事 OR 会社) 行きたくない"

class TwisController < ApplicationController
  def index
    @log = Logs.all
    # @chart_data = Logs.all.order('date').group(:date).sum(:count)
    days = get_daycount(0, Logs.all.count)
    # if days == -1 # error function FIXME
    @chart_data = Logs.select(:date, :count).limit(days).order(date: :desc).pluck(:date, :count)
  end

  private
  def get_daycount(min, max)
    days = params[:days].to_i
    if days <= min or days > max
      7
    else
      days
    end
  end
end
