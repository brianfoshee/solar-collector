require 'sinatra'
require 'sinatra/activerecord'

set :database, "postgres://localhost:5432/solar-collector-dev"

class Reading < ActiveRecord::Base
  validates :read_time, presence: :true
  validates :data, presence: :true
end
