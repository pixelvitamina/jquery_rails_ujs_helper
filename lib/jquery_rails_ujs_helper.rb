module JqueryRailsUjsHelper
  UJS_CLASS = {:class => "ujs"}
  
  def ujs_link_to(name, options = {}, html_options = nil)
    if html_options
      then html_options = html_options.merge(UJS_CLASS)
      else html_options = UJS_CLASS
    end
    
    link_to(name, options, html_options)
  end
  
  def ujs_form_for(record_or_name_or_array, *args, &proc)
    if args.empty?
      args = UJS_CLASS
    else
      args.each_with_index do |a, index|
        next unless a.is_a?(Hash) && a.has_key?(:html)
        args[index] = {:html => a[:html].merge!(UJS_CLASS)}
      end
    end
    
    form_for(record_or_name_or_array, args.pop, &proc)
  end
  
  def ujs_form_tag(url_for_options = {}, options = {}, *parameters_for_url, &block)
    if options.blank?
      then options = UJS_CLASS
      else options = options.merge(UJS_CLASS)
    end

    form_tag(url_for_options = {}, options, *parameters_for_url, &block) 
  end
  
  def yield_authenticity_token
    if protect_against_forgery?
      <<-JAVASCRIPT
<script type='text/javascript'>
  //<![CDATA[
    window._auth_token_name = "#{request_forgery_protection_token}";
    window._auth_token = "#{form_authenticity_token}";
  //]]>
</script>
      JAVASCRIPT
    end
  end
  
end
