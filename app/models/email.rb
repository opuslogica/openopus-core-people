class Email < ApplicationRecord
  belongs_to :label, optional: true
  belongs_to :emailable, polymorphic: true
  accepts_nested_attributes_for :label
  before_create :default_label

  def self.canonicalize(addr)
    addr.strip.downcase if not addr.blank?
  end

  def canonicalize
    self.address = self.class.canonicalize(self.address)
  end

  def default_label
    self.label = Label.get("Work")
  end

end
