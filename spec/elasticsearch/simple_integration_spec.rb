require 'spec_helper'

class UserIndexer < Elasticsearch::Indexer
  def index_name
    'elasticsearch_simple'
  end

  def index_body
    { name: name }
  end
end

describe Elasticsearch::Simple do
  describe 'Elasticsearch::Indexer.create' do
    it "creates index" do
      user = double(id: 123, name: 'Joe')
      indexer = UserIndexer.new(user)
      indexer.create
      es_client = make_es_client
      result = es_client.get index: 'elasticsearch_simple', type: 'user', id: 123
      expect(result).not_to be_nil
    end
  end

  describe 'Elasticsearch::Indexer.create' do
    it "creates index" do
      es_client = make_es_client
      user = double(id: 123, name: 'Joe')
      es_client.index index: 'elasticsearch_simple',
                      type:  'user',
                      id: user.id,
                      body: { name: 'joe' }
      indexer = UserIndexer.new(user)
      indexer.delete
      expect do
        es_client.get index: 'elasticsearch_simple', type: 'user', id: 123
      end.to raise_error(Elasticsearch::Transport::Transport::Errors::NotFound)
    end
  end

  def make_es_client
    Elasticsearch::Client.new
  end
end
