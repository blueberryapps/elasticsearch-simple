module Elasticsearch
  module IndexableModel

    def self.included(base)
      base.send :after_commit, :create_es_index,
                if: :indexer_class,
                on: :create
      base.send :after_destroy, :delete_es_index,
                if: :indexer_class
    end

    def indexer_class
      "#{self.class.name}Indexer".safe_constantize
    end

    def indexer_instance
      @indexer_instance ||= indexer_class.new(self)
    end

    def create_es_index
      indexer_instance.create
    end

    def delete_es_index
      indexer_instance.delete
    end

  end
end
