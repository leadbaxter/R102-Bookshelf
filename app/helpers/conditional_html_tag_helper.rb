module ConditionalHtmlTagHelper
  def conditional_html( lang = "en", &block )
    # http://gf3.ca/2011/02/12/conditional-html-tag-haml
    haml_concat Haml::Util::html_safe <<-"HTML".gsub( /^\s+/, '' )
      <!-- paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither/ -->
      <!--[if lt IE 7 ]>              <html lang="#{lang}" class="no-js ie6"> <![endif]-->
      <!--[if IE 7 ]>                 <html lang="#{lang}" class="no-js ie7"> <![endif]-->
      <!--[if IE 8 ]>                 <html lang="#{lang}" class="no-js ie8"> <![endif]-->
      <!--[if IE 9 ]>                 <html lang="#{lang}" class="no-js ie9"> <![endif]-->
      <!--[if (gte IE 9)|!(IE)]><!--> <html lang="#{lang}" class="no-js"> <!--<![endif]-->
    HTML
    haml_concat capture( &block ) << Haml::Util::html_safe( "\n</html>" ) if block_given?
  end
end