# encoding: utf-8
require "spec_helper"

if ActiveRecord::VERSION::MAJOR >= 3
  require "gettext_i18n_rails/active_model/name"

  describe ActiveModel::Name do
    before do
      FastGettext.reload!
    end

    describe 'human' do
      it "is translated through FastGettext" do
        name = ActiveModel::Name.new(CarSeat)
        name.should_receive(:_).with('Car seat').and_return('Autositz')
        name.human.should == 'Autositz'
      end
    end
  end
end
