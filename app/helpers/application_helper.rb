module ApplicationHelper
	def logo
		image_tag("logo.png", :alt => "Sample App", :class => "round")
	end

	def title
		if @title.nil?
			"empty"
		else
			@title
		end
	end
end
