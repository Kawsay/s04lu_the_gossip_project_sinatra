require 'csv'
require 'pry'

class Gossip
  attr_reader :author, :content
  @@id = 0

  def initialize(author, content)
    @author = author
    @content = content
    @@id = @@id + 1
    @id = @@id
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  def self.find(id)
    row = CSV.read("./db/gossip.csv")[id.to_i - 1]
    Gossip.new(row[0], row[1])
  end

  def self.edit(id, author, content)
    gossips = Gossip.all
    gossips[id.to_i] = Gossip.new(author,content)
    CSV.open("./db/gossip.csv",'w') do |csv|
      csv =""
    end
    
    gossips.each do |gossip|
      gossip.save
    end
  end

  # def self.edit(id, content)
  #   all_gossips = self.all
  #   CSV.open("./db/gossip.csv", "w") do |csv|
  #     csv = content
  #   end
  #   all_gossips.each {|g| g.save}
  # end

  # def find_id(gossip_content)
  #   id = CSV.
  # end
end

# binding.pry