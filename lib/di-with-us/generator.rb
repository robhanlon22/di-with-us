class DIWithUs::Generator
  SEED = 'Healthy Times Fun Club'

  def initialize(api_key)
    @api_key = api_key
    @current = SEED.split
  end

  def generate!
    @current.map
  end
end
