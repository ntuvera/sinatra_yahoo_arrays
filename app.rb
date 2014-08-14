require 'bundler/setup'
Bundler.require

get '/' do
  erb :index
end


#get '/stock/:ticker' do |ticker|
#@ticker = "#{ticker}"
#data    = YahooFinance.historical_quotes(@ticker, Time::now-(24*60*60*10), Time::now)
#@trade_date_arr    = [data[0].trade_date, data[1].trade_date, data[2].trade_date, data[3].trade_date, data[4].trade_date]
#@open_arr          = [data[0].open, data[1].open, data[2].open, data[3].open, data[4].open]
#@close_arr         = [data[0].close, data[1].open, data[2].close, data[3].close, data[4].close]
#@high_arr          = [data[0].high, data[1].high, data[2].high, data[3].high, data[4].high]
## {:date => trade_date_arr}
#binding.pry
#erb :show
# end

get '/stock/:ticker' do
  @ticker = params['ticker']
  data = YahooFinance.historical_quotes(@ticker, Time::now-(24*60*60*10), Time::now)
  @trade_date_arr, @open_arr, @close_arr, @high_arr = [],[],[],[]
  data.take(5).map { |ele| @trade_date_arr.push(ele.trade_date) }
  data.take(5).map { |ele| @open_arr.push(ele.open) }
  data.take(5).map { |ele| @close_arr.push(ele.close) }
  data.take(5).map { |ele| @high_arr.push(ele.high) }
  erb :show
end

post '/stock/:ticker' do
  ticker = params[:ticker_name]      
  redirect "/stock/#{ticker}"
  binding.pry
end


