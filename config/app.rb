require 'sinatra'
require 'sinatra/activerecord'

set :database, "postgres://localhost:5432/solar-collector-dev"

class Reading < ActiveRecord::Base
  validates :read_time, presence: :true
  validates :data, presence: :true
end

post '/readings' do
  content_type :json
  reading = request.body.read
  data = JSON.parse(reading)
  # TODO: refactor this for proper input format
  time = data.delete('read_time')
  time = Time.at(time) if !time.nil?
  r = Reading.new(data: data, read_time: time)
  if r.save
    r.data.to_s
  else
    "Could not save #{r.errors.messages}"
  end
end

# Format is:
# {
#   "Ahc_daily": {
#       "1380908350": 9.8,
#       "1380908355": 9.8,
#       "1380908399": 9.8,
#       "1380908404": 9.8
#     }
# }
