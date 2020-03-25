require_relative('../db/sql_runner')


class Artist

  def initialize(options)
    @id = options['id'].to_int if options['id']
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

end
