describe MetricsHash do
  let(:metrics_hash) do
    metrics = MetricsHash.new

    metrics['request_controller']   = 'pages'
    metrics['request_action']       = 'root'
    metrics['request_ip']           = '::1'
    metrics['request_xff']          = ''
    metrics['request_requestor_ip'] = '::1'
    metrics['request_url']          = 'http://localhost:5000/'
    metrics['request_method']       = 'GET'

    metrics
  end

  it '#[]=' do
    expect(metrics_hash.[]=('hello', 'goodbye')).to eq('goodbye')
  end

  it '#[]' do
    expect(metrics_hash.[]('hello')).to eq(nil)
  end

  it '#clear' do
    expect(metrics_hash.clear).to eq({})
  end

  it '#to_s' do
    expect(metrics_hash.to_s).to eq('request_action=root request_controller=pages request_ip=::1 request_method=GET request_requestor_ip=::1 request_url=http://localhost:5000/ request_xff=""')
  end
end
