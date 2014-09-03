class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  validates_presence_of :email
  #mount_uploader :image, ImageUploader
  has_many :authorizations
  
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" },
  :url  => "/assets/avatars/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/avatars/:id/:style/:basename.:extension"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def self.new_with_session(params,session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"],without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def self.from_omniauth(auth, current_user)
    authorization = Authorization.where(:provider => auth.provider, :uid => auth.uid.to_s, :token => auth.credentials.token, :secret => auth.credentials.secret).first_or_initialize
    if authorization.user.blank?
      user = current_user.nil? ? User.where('email = ?', auth["info"]["email"]).first : current_user
      if user.blank?
       user = User.new
       
       user.password = Devise.friendly_token[0,10]
       user.display_name = auth.info.name
       user.username = auth.info.nickname
       user.email = auth.info.email

       user.remote_avatar_url = auth.info.image if auth.info.image.present?
       auth.provider == "twitter" ?  user.save(:validate => false) :  user.save
      end
     authorization.username = auth.info.nickname
     authorization.user_id = user.id
     authorization.save
   end
   authorization.user
 end

end
