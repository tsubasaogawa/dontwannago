# coding: utf-8

class TwisController < ApplicationController
  def index
    @log = Logs.all
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
