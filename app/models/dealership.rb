class Dealership < ActiveRecord::Base
  acts_as_paranoid
  paginates_per 5

  validates :title, presence: true

  has_many :users do
    def service_advisors
      service_advisor
    end

    def dealers
      dealer
    end

    def technicians
      technician
    end
  end

  rails_admin do
    edit do
      field :id
      field :created_at
      field :updated_at
      field :title
      field :address
    end

    edit do
      field :title
      field :address
    end

    show do
      field :id
      field :title
      field :address
      field :created_at
      field :updated_at
    end

    object_label_method do
      :custom_title
    end
  end

  def custom_title
    "##{self.id} #{title || 'Dealership'}"
  end
end