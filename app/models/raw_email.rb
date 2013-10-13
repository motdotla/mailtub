class RawEmail < ActiveRecord::Base
  validates :redis_key, presence: true, uniqueness: true
  validates :source,    presence: true

  before_save :set_microtime

  def self.redis_keys
    REDIS.keys
  end

  def self.sync!
    redis_keys.each do |key|
      source  = REDIS.get key
      #begin
        success = self.create(redis_key: key, source: source)
        REDIS.del key if success
      #rescue => e
      #  puts "probably invalid byte sequence"
      #end
    end
  end

  def mail
    @mail = Mail.read_from_string(source)
  end

  private

  def set_microtime
    parts           = redis_key.split("|")
    self.microtime  = parts[0].to_i if parts
  end
end
