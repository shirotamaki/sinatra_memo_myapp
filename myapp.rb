# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'erb'
require 'json'

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

get '/memos' do
  files = Dir.glob('./json/*.json')
  memos = files.map { |f| JSON.parse(File.open(f).read, symbolize_names: true) }
  @memos = memos.sort_by { |m| m[:created_at] }
  erb :index
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  memo = { id: SecureRandom.uuid, title: params[:title], content: params[:content], created_at: Time.new }
  File.open("./json/memos_#{memo[:id]}.json", 'w') do |file|
    JSON.dump(memo, file)
  end
  redirect to("/memos/#{memo[:id]}")
end

get '/memos/:id' do
  # file = Dir.glob("./json/memos_#{params[:id]}.json")
  # @memo = file.map { |f| JSON.parse(File.open(f).read, symbolize_names: true) }
  file = Dir.glob("./json/memos_#{params[:id]}.json").first
  @file = JSON.parse(file)
  erb :show
end

get '/memos/:id/edit' do
  file = Dir.glob("./json/memos_#{params[:id]}.json")
  @memo = file.map { |f| JSON.parse(File.open(f).read, symbolize_names: true) }
  erb :edit
end

patch '/memos/:id' do
  memo = { id: params[:id], title: params[:title], content: params[:content], created_at: Time.new }
  File.open("./json/memos_#{memo[:id]}.json", 'w') do |file|
    JSON.dump(memo, file)
  end
  redirect to("/memos/#{params[:id]}")
end

delete '/memos/:id' do
  File.delete("./json/memos_#{params[:id]}.json")
  redirect to('/memos')
end

not_found do
  erb :not_found
end
