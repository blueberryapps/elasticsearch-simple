require 'delegate'
require 'active_support/inflector'

module Elasticsearch
  class Indexer < SimpleDelegator

    attr_writer :es_client

    def delete
      es_client.delete index: index_name,
                       type:  type_name,
                       id: id
    end

    def create
      es_client.index index: index_name,
                      type:  type_name,
                      id: id,
                      body: index_body
    end

    def index_body
    end

    def index_name
    end

    def type_name
      self.class.name[/\A(.+)Indexer\z/, 1].underscore
    end

    private

    def es_client
      @es_client ||= Elasticsearch::Client.new log: true
    end

  end
end
