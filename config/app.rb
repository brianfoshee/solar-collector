require 'sinatra'
require 'sinatra/activerecord'

set :database, "postgres://localhost:5432/solar-collector-dev"

class Reading < ActiveRecord::Base
  validates :read_time, presence: :true
  validates :data, presence: :true
end

post '/readings' do
  reading = request.body.read
  data = JSON.parse(reading)
  time = data.delete('read_time')
  time = Time.at(time) if !time.nil?
  r = Reading.new(data: data, read_time: time)
  if r.save
    r.data.to_s
  else
    "Could not save #{r.errors.messages}"
  end
end
