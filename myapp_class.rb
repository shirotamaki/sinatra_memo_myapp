# frozen_string_literal: true

class Memo
  def conn
    @connection ||= PG.connect(dbname: 'memos')
  end
end
