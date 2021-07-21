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

get '/memos' do
  conn = PG.connect(dbname: 'memos')
  @memos = conn.exec('SELECT * FROM t_memos;')
  erb :index
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  conn = PG.connect(dbname: 'memos')
  conn.exec("INSERT INTO t_memos (title, content) VALUES ('#{params['title']}', '#{params['content']}');")
  redirect to('/memos')
end

get '/memos/:id' do
  conn = PG.connect(dbname: 'memos')
  @memos = conn.exec('SELECT * FROM t_memos WHERE id = $1;', [params['id']])
  erb :show
end

get '/memos/:id/edit' do
  conn = PG.connect(dbname: 'memos')
  @memos = conn.exec('SELECT * FROM t_memos WHERE id = $1;', [params['id']])
  erb :edit
end

delete '/memos/:id' do
  conn = PG.connect(dbname: 'memos')
  conn.exec('DELETE FROM t_memos WHERE id = $1;', [params['id']])
  redirect to('/memos')
end

patch '/memos/:id' do
  conn = PG.connect(dbname: 'memos')
  conn.exec("UPDATE t_memos SET title = '#{params['title']}', content = '#{params['content']}' WHERE id = $1;", [params['id']])
  redirect to('/memos')
end

not_found do
  erb :not_found
end
