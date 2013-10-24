require 'spec_helper'

describe Elasticsearch::Indexer do

  it 'delegates methods' do
    indexer = Elasticsearch::Indexer.new(make_delegate)
    expect(indexer.id).to eq 321
  end

  describe '#index' do
    it 'calls to es_client#index' do
      es_client = double index: true
      indexer = Elasticsearch::Indexer.new(make_delegate)
      indexer.es_client = es_client

      expect(es_client).to receive(:index)
      indexer.index
    end
  end

  describe '#type_name' do
    it 'returns type name based on class name' do
      UserIndexer = Class.new(Elasticsearch::Indexer)
      user_indexer = UserIndexer.new(make_delegate)
      expect(user_indexer.type_name).to eq 'user'
    end
  end

  def make_delegate
    double id: 321
  end

end
