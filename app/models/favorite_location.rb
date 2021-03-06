class FavoriteLocation < ActiveRecord::Base
  unloadable

  self.table_name = 'favorite_link_locations'

  belongs_to :user

  validates :user_id, :uniqueness => { :scope => :link_path }, :presence => true
  validates :link_path, :presence => true

  attr_accessible :link_path, :page_title

  before_save :normalize_link_path

  def self.for_user(user)
    where(:user_id => user.id)
  end

  def page_title
    read_attribute(:page_title).presence || link_path
  end

  # prepend '/' to link_path
  def normalize_link_path
    return if link_path.blank?
    link_path.insert(0, '/') unless link_path[0] == '/'
  end
end
