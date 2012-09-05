require 'spec_helper'

describe NotificationsController do
  describe 'routing' do
    it 'routes to #post_full_name' do
      post('notifications/post_full_name').should route_to('notifications#post_full_name')
    end
  end
end
