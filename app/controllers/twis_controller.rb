# coding: utf-8

# SEARCH_QUERY = "(学校 OR 仕事 OR 会社) 行きたくない"

class TwisController < ApplicationController
  def index
    @log = Logs.all
    # @chart_data = Logs.all.order('date').group(:date).sum(:count)
    days = params[:days].to_i
    end if days <= 0 or days > 365
    @chart_data = Logs.select(:date, :count).limit(days).order(date: :desc).pluck(:date, :count)
  end
end
