# frozen_string_literal: true

shared_examples 'Access denied' do
  it 'responds with 401' do
    subject
    expect(response).to have_http_status(:unauthorized)
  end

  it 'responds with proper body' do
    subject
    expect(response_body).to eq('error' => I18n.t('authorization.unauthorized'))
  end
end

shared_examples 'Unauthenticated' do
  it 'denies access' do
    subject
    expect(response_body)
      .to eq('error' => I18n.t('authorization.unauthenticated'))
  end
end

shared_examples '200' do
  it 'responds with success status' do
    subject
    expect(response).to have_http_status(:ok)
  end
end

shared_examples 'responds with JSON' do
  it 'responds with JSON' do
    subject
    expect(response.content_type).to eq('application/json')
  end
end

shared_examples '204' do
  it 'responds with success status' do
    subject
    expect(response).to have_http_status(:no_content)
  end

  it 'responds with proper body' do
    subject
    expect(response.body).to eq('')
  end
end

shared_examples '201' do
  it 'responds with success status' do
    subject
    expect(response).to have_http_status(:created)
  end

  it 'responds with proper body' do
    subject
    expect(response.body).to eq(response_body.to_json)
  end
end

shared_examples '404' do
  it 'returns 404 status' do
    subject
    expect(response).to have_http_status(404)
  end
end
