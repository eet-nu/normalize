$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'normalize'

ActiveRecord::Base.silence do
  ActiveRecord::Migration.verbose = false
  ActiveRecord::Base.configurations = { 'test' => { adapter: 'sqlite3', database: ':memory:' } }
  ActiveRecord::Base.establish_connection :test
  
  ActiveRecord::Schema.define version: 0 do
    create_table 'books', force: true do |t|
      t.string :title
      t.string :author
      t.string :isbn
    end
  end
end

class TitleNormalizer
  def self.call(title)
    title.upcase
  end
end

class AuthorNormalizer
  def self.call(author)
    author.split(' ').map do |name|
      name[0] = name[0].upcase
      name
    end.join(' ')
  end
end
