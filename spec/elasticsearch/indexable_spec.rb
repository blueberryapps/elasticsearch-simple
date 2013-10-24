require 'spec_helper'

describe Elasticsearch::IndexableModel do

  describe '.included' do

    it 'creates after_commit callback' do
      base = double after_commit: true,
                    after_destroy: true

      expect(base).to receive(:after_commit).with(
        :create_es_index, anything)
      Elasticsearch::IndexableModel.included(base)
    end

    it 'creates after_destroy callback' do
      base = double after_commit: true,
                    after_destroy: true
      expect(base).to receive(:after_destroy).with(
        :delete_es_index, anything)
      Elasticsearch::IndexableModel.included(base)
    end

  end

  describe '#create_es_index' do
    it 'calls #create on indexer_instance' do
      indexer_instance = double create: true
      model_instance = make_model_instance(indexer_instance)
      expect(indexer_instance).to receive(:create)
      model_instance.create_es_index
    end
  end

  describe '#delete_es_index' do
    it 'calls #create on indexer_instance' do
      indexer_instance = double create: true
      model_instance = make_model_instance(indexer_instance)
      expect(indexer_instance).to receive(:delete)
      model_instance.delete_es_index
    end
  end

  def make_model_class
    Class.new do
      def self.after_commit(*args); end
      def self.after_destroy(*args); end

      include Elasticsearch::IndexableModel
    end
  end

  def make_model_instance(indexer_instance)
    model_class = make_model_class
    model_instance = model_class.new
    model_instance.instance_variable_set(:@indexer_instance, indexer_instance)
    model_instance
  end

end
