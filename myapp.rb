# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'erb'
require 'pg'
require_relative 'memo_class'

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

memo = Memo.new

get '/memos' do
  @memos = memo.get_memos
  erb :index
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  @memo = memo.create(params['title'], params['content'])
  redirect to('/memos')
end

# メソッドが機能しない
get '/memos/:id' do
  conn = PG.connect(dbname: 'memos')
  @memos = conn.exec(" SELECT * FROM memos WHERE id = '#{params['id']}' ")
  erb :show
end

# メソッドが機能しない
get '/memos/:id/edit' do
  conn = PG.connect(dbname: 'memos')
  @memos = conn.exec(" SELECT * FROM memos WHERE id = '#{params['id']}' ")
  erb :edit
end

delete '/memos/:id' do
  memo.delete(params['id'])
  redirect to('/memos')
end

patch '/memos/:id' do
  memo.edit(params['title'], params['content'], params['id'])
  redirect to('/memos')
end

not_found do
  erb :not_found
end
