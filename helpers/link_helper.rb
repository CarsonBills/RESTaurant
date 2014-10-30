module Sinatra
	module LinkHelper
		def link_to(url_or_record, body)
			return "<a href='#{url_or_record}>#{body}</a>" if url_or_record is_a? String
			link_to(record_path(url_or_record), body)
		end
		def record_path(record)
			table_name = record.class.table_name
			record_id = record.id
			"/#{table_name}/#{record_id}"
		end
	end
	helpers LinkHelper
end





