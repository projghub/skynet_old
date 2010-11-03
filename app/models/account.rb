class Account < ActiveRecord::Base
	has_many :campaigns
	has_many :users
	validates_presence_of :name
	validates_format_of :email, :with => /\A(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}\Z/
end
