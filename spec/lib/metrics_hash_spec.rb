describe MetricsHash do
  it 'can output a neato string' do
    metrics = MetricsHash.new
    metrics['request_controller']   = 'pages'
    metrics['request_action']       = 'root'
    metrics['request_ip']           = '::1'
    metrics['request_xff']          = ''
    metrics['request_requestor_ip'] = '::1'
    metrics['request_url']          = 'http://localhost:5000/'
    metrics['request_method']       = 'GET'

    expect(metrics.to_s).to eq('request_action=root request_controller=pages request_ip=::1 request_method=GET request_requestor_ip=::1 request_url=http://localhost:5000/ request_xff=""')
  end
end
