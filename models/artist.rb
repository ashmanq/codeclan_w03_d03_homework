require_relative('../db/sql_runner')
require_relative('./album')

class Artist
  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO artists
        (
          name
          )
          VALUES
          (
            $1
          )
          RETURNING *"

    values = [@name]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def update()
    sql = "UPDATE artists SET
            name = $1
            WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM artists"
    artists_hash = SqlRunner.run(sql, [])
    return artists_hash.map {|artist| Artist.new(artist)}
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql, [])
  end

  def delete()
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def albums()
    sql = "SELECT * FROM albums where artist_id = $1"
    values = [@id]
    albums_hash = SqlRunner.run(sql, values)
    return albums_hash.map {|album| Album.new(album)}
  end

end
