require 'digest/sha1'

class User < ActiveRecord::Base
	belongs_to :account
	attr_accessor :password, :password_confirmation, :current_user_id
	attr_protected :account_id, :password_hash, :salt, :current_user_id
	validates_presence_of :account_id, :username
	validates_uniqueness_of :username
	validates_confirmation_of :password
	validates_presence_of :password, :password_confirmation, :on => :create
	validates_format_of :email, :with => /\A(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}\Z/
	validate :valid_not_current_user
	after_validation :set_password
	default_scope where(:deleted_at => nil)

	def hash_password(password)
		User.hash_password_and_salt password, self.salt
	end

	def password_matches?(password)
		hash_password(password) == self.password_hash
	end

	def set_password
		unless self.password.nil? || self.password.empty?
			self.salt = Digest::SHA1.hexdigest(Time.now.to_s) unless self.salt?
			self.password_hash = hash_password(self.password)
		end
	end

	def self.authenticate(username, password)
		user = User.joins(:account).where("users.username = ? AND users.enabled = ? AND accounts.enabled = ?", username, true, true).first rescue nil
		return nil if user.nil? || !user.password_matches?(password)
		user
	end

	def self.hash_password_and_salt(password, salt)
		Digest::SHA1.hexdigest(salt+password)
	end

	def valid_not_current_user
		errors.add :deleted_at, "cannot delete your user, because then you won't be able to do anything :(" unless self.deleted_at.nil? || self.id != self.current_user_id
	end
end
