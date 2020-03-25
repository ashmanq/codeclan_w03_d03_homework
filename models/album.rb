require_relative('../db/sql_runner')


class Album

  attr_accessor :title, :genre, :artist_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

  def save()
    sql = "INSERT INTO albums
          (
            title,
            genre,
            artist_id
            )
            VALUES
            (
              $1, $2, $3
            )
            RETURNING *"
    values = [@title, @genre, @artist_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def update()
    sql = "UPDATE albums SET
            (
              title,
              genre,
              artist_id
              )
              =
              (
                $1, $2, $3
              )
              WHERE id = $4"
    values = [@title, @genre, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM albums"
    albums_hash = SqlRunner.run(sql, [])
    return albums_hash.map {|album| Album.new(album)}
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql, [])
  end

  def delete()
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    result = SqlRunner.run(sql, values)[0]
    # We only expect one value so we take the
    # zero index of the returned array
    return Artist.new(result)
  end

  def self.find(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    result_hash = SqlRunner.run(sql, values).first
    return nil if result_hash == nil
    return Album.new(result_hash)
  end

end
