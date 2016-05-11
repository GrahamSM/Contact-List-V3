class Contact < ActiveRecord::Base
  has_many :numbers
  validates :name, :email, presence: true

  def has_number?
    Number.find(self.id) ? true : false
  end

  def get_number
    Number.find(self.id).number
  end

end
