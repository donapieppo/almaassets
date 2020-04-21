class Upload
  attr_accessor :organization_id

  def initialize(organization)
    @organization_id = organization.id
  end

end
