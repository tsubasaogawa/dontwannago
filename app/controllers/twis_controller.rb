# coding: utf-8

class TwisController < ApplicationController
  def index
    @log = Logs.all
  end
end
