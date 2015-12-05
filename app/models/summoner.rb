class Summoner
  include ActiveModel::Serializers::JSON

  attr_accessor :id, :name, :summoner_level, :profile_icon_id, :revision_date

  def attributes=(hash)
    hash.each do |key, value|
      send("#{key.underscore}=", value)
    end
  end

  def attributes
    {'id' => nil, 'name' => nil, 'summoner_level' => nil, 'profile_icon_id' => nil, 'revision_date' => nil}
  end

  def as_json(options)
    camelize_keys(super(options))
  end

  def camelize_keys(hash)
    values = hash.map do |key, value|
      [key.camelize(:lower), value]
    end
    Hash[values]
  end


end