RSpec.describe OpportunitiesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/opportunities').to route_to('opportunities#index')
    end

    it 'routes to #show' do
      expect(get: '/opportunities/1').to route_to('opportunities#show', id: '1')
    end
  end
end
