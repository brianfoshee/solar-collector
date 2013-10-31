require 'sinatra'
require 'sinatra/activerecord'

set :database, "postgres://localhost:5432/solar-collector-dev"

class Reading < ActiveRecord::Base
  store_accessor :data, :Sweep_Pmax, :Ahc_r, :Vb_ref, :Ahc_t, :Power_out,
  :adc_va_f, :T_amb, :T_hs, :Ahl_r, :adc_vb_f, :Sweep_Vmp, :Vb_min_daily,
  :Vb_max_daily, :Ahl_t, :kWhc, :hourmeter, :adc_ic_f, :adc_vl_f, :Sweep_Voc,
  :adc_il_f, :charge_state, :Ahl_daily, :Ahc_daily, :Vb_f, :V_lvd

  validates :read_time, presence: :true
  validates :data, presence: :true
end

post '/readings' do
  content_type :json
  reading = request.body.read
  data = JSON.parse(reading)
  old, knew = 0, 0
  data.each do |k,v|
    label = k
    v.each do |k,v|
      t = Time.at(k.to_i).to_s
      tstamp = DateTime.parse(t)
      r = Reading.find_or_create_by(read_time: tstamp)
      r.send("#{label.to_sym}=", v)
      if r.new_record?
        knew += 1
      else
        old +=1
      end
      r.save!
    end
  end
  "{ data: { old: #{old}}, new: #{knew} }"
end
