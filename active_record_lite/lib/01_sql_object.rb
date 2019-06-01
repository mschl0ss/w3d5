require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject

  def self.columns
    # ...
    
    unless @data2
      @data2 = DBConnection.execute2(<<-SQL)
        SELECT * FROM #{self.table_name}
      SQL
      
    end
    
    @data2.first.map { |datum| datum.to_sym}
  end

  def self.finalize!
    # ...

    #for each column in the table...
    columns.each do |column|

      # ...define getters ie instance.{column}
      define_method(column) do
        attributes[column]
      end

      # ...define setters ie instance.{column} = val
      define_method("#{column}=") do |val|
        attributes[column] = val
      end
    end
  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name
  end

  def self.table_name
    # ...
    input = "#{self}"
    @table_name = input.downcase + "s"
  end

  def self.all
    # ...
    data = DBConnection.execute(<<-SQL)
      SELECT * FROM #{self.table_name}
    SQL

    data.map { |datum| self.new(datum)}
  end

  def self.parse_all(results)
    # ...
      results.map do |result|
        self.new(result)
      end
  end

  def self.find(id)
    # ...
    self.all.each do |instance|
      return instance if instance.id == id
    end
    nil
  end

  def initialize(params = {})
    # ...
    params.each do |k,v|
      raise "unknown attribute '#{k}'" unless self.class.columns.include?(k.to_sym)
      self.send("#{k}=", v)

    end
  end

  def attributes
    # ...
    @attributes ||= {}
  end

  def attribute_values
    # ...

    self.instance_variables.map do |var|
      self.send(var)
    end
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
