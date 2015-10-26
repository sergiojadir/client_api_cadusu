module ApplicationHelper
	def flash_message    
    messages = ""
    [:notice, :info, :warning, :error, :success, :danger, :alert].each {|type|
      if flash[type]
        msg = flash[type]
        type = type == :alert ? :danger : type
        messages += "<div class='alert alert-#{type} fade in'><button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>#{msg}</div>"
      end
    }

    raw messages
  end
end
