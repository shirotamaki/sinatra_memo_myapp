# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'erb'
require 'pg'
require_relative 'myapp_class'

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

memo = Memo.new

get '/memos' do
  @memos = memo.conn.exec('SELECT * FROM t_memos;')
  erb :index
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  memo.conn.exec('INSERT INTO t_memos (title, content) VALUES ($1, $2);', [params['title'], params['content']])
  redirect to('/memos')
end

get '/memos/:id' do
  @memos = memo.conn.exec('SELECT * FROM t_memos WHERE id = $1;', [params['id']])
  erb :show
end

get '/memos/:id/edit' do
  @memos = memo.conn.exec('SELECT * FROM t_memos WHERE id = $1;', [params['id']])
  erb :edit
end

delete '/memos/:id' do
  memo.conn.exec('DELETE FROM t_memos WHERE id = $1;', [params['id']])
  redirect to('/memos')
end

patch '/memos/:id' do
  memo.conn.exec('UPDATE t_memos SET title = $1, content = $2 WHERE id = $3;', [params['title'], params['content'], params['id']])
  redirect to('/memos')
end

not_found do
  erb :not_found
end
