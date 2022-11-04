require_relative 'test_helper'

class FluxbbTest < MiniTest::Unit::TestCase
  def fluxbb_tags
    return {
      img: RubyBBCode::Tags.tag_list[:img].merge(
        :html_open => '<img src="%between%"%alt_text%/>',
        :html_close => '',
        :example => '[img=my alt text]http://www.google.com/intl/en_ALL/images/logo.gif[/img]',
        :tag_param => /(.*)/,
        :tag_param_tokens => [{:token => :alt_text, :prefix => ' alt="', :postfix => '"'}],
        :tag_param_description => 'The img bbcode takes alt text as a parameter'
      ),
    }
  end

  def test_image_with_alt_text
    assert_equal '<img src="http://www.ruby-lang.org/images/header-ruby-logo.png" alt="FluxBB allows alt text"/>',
                   '[img=FluxBB allows alt text]http://www.ruby-lang.org/images/header-ruby-logo.png[/img]'.bbcode_to_md(false, fluxbb_tags)
  end

  def test_image_without_alt_text
    assert_equal '<img src="http://www.ruby-lang.org/images/header-ruby-logo.png"/>',
                   '[img]http://www.ruby-lang.org/images/header-ruby-logo.png[/img]'.bbcode_to_md(false, fluxbb_tags)
  end

  def test_ignored_attempt_to_pass_width_height
    assert_equal '<img src="http://www.ruby-lang.org/images/header-ruby-logo.png" alt="100x200"/>',
                   '[img=100x200]http://www.ruby-lang.org/images/header-ruby-logo.png[/img]'.bbcode_to_md(false, fluxbb_tags)
  end
end
