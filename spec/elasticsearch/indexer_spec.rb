require 'spec_helper'

describe Elasticsearch::Indexer do

  it 'delegates methods' do
    indexer = Elasticsearch::Indexer.new(make_delegate)
    expect(indexer.id).to eq 321
  end

  describe '#delete' do
    it 'calls to es_client#delete' do
      es_client = double delete: true
      indexer = make_indexer_instance
      indexer.es_client = es_client

      expected_hash = { index: nil, type: 'test', id: 321 }
      expect(es_client).to receive(:delete).with(expected_hash)
      indexer.delete
    end
  end

  describe '#index' do
    it 'calls to es_client#index' do
      es_client = double index: true
      indexer = make_indexer_instance
      indexer.es_client = es_client

      expected_hash = { index: nil, type: 'test', id: 321, body: nil }
      expect(es_client).to receive(:index).with(expected_hash)
      indexer.index
    end
  end

  describe '#type_name' do
    it 'returns type name based on class name' do
      indexer = make_indexer_instance
      expect(indexer.type_name).to eq 'test'
    end
  end

  def make_delegate
    double id: 321
  end

  def make_indexer_class(name = 'TestIndexer')
    indexer_class = Class.new(Elasticsearch::Indexer)
    allow(indexer_class).to receive(:name).and_return 'TestIndexer'
    indexer_class
  end

  def make_indexer_instance(delegate = make_delegate)
    indexer_class = make_indexer_class
    indexer_class.new(delegate)
  end

end
