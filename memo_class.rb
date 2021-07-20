# frozen_string_literal: true

class Memo
  def initialize
    @connection = PG.connect(dbname: 'memos')
  end

  def get_memos
    @connection.exec('SELECT * FROM memos;')
  end

  def get_memo(id)
    @connection.exec("SELECT * FROM memo WHERE id = $1;", [id])
  end

  def create(title, content)
    @connection.exec("INSERT INTO memos (title, content) VALUES ( title = $2, content = $3);", [title, content])
  end

  def edit(title, content, id)
    @connection.exec("UPDATE memos SET (title = $2, content = $3 WHERE id = $1);", [title, content, id])
  end

  def delete(id)
    @connection.exec("DELETE FROM memos WHERE id = '#{id}';")
  end
end
