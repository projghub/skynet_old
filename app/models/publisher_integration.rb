class PublisherIntegration
	include ActiveModel::Validations

	attr_accessor :tid, :type, :attribute_value_ids
	validates_presence_of :tid, :type
	validates_inclusion_of :type, :in => %w(iframe script)

	def initialize(params = {})
		self.tid = params[:tid] || nil
		self.type = params[:type] || nil
		self.attribute_value_ids = params[:attribute_value_ids] || []
	end
end

