require "spec_helper"
require "gettext_i18n_rails/hamlet_parser"

describe GettextI18nRails::HamletParser do
  def pending_if(xx, &block)
    if xx
      pending(&block)
    else
      yield
    end
  end

  let(:parser){ GettextI18nRails::HamletParser }

  describe "#target?" do
    it "targets .hamlet" do
      parser.target?('foo/bar/xxx.hamlet').should == true
    end

    it "does not target anything else" do
      parser.target?('foo/bar/xxx.erb').should == false
    end
  end

  describe "#parse" do
    it "finds messages in hamlet" do
      pending_if(RUBY_VERSION < "1.9") do
        with_file '<div>= _("xxxx")' do |path|
          parser.parse(path, []).should == [
            ["xxxx", "#{path}:1"]
          ]
        end
      end
    end

    it "does not find messages in text" do
      with_file '<div> _("xxxx")' do |path|
        parser.parse(path, []).should == []
      end
    end
  end
end

