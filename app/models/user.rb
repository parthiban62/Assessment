class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :surveys
  belongs_to :role

  has_many :responses

  after_initialize :set_default_role, :if => :new_record?

  def is_admin?
  	role.name.eql?("Admin")
  end

  def set_default_role
  	self.role ||= Role.find_by_name('SiteUser')
  end

end
