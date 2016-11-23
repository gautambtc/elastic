class Document < ActiveRecord::Base
  # We're mounting the uploader the document_attachment attribute.
  # This attribute will store the path to the attachment.
  mount_uploader :document_attachment, DocumentAttachmentUploader
  
  # Setting up ElasticSearch integration
  include Tire::Model::Search
  include Tire::Model::Callbacks
  
  mapping _source: { excludes: ['attachment'] } do
    indexes :id, type: 'integer'
    indexes :title
    indexes :attachment, type: 'attachment'




  end

  def attachment
    # path_to_attachment = document_attachment.file.file
    # open(path_to_attachment) { |file| file.read }
     Base64.encode64 open(document_attachment.path).read
  end

  def to_indexed_json
    to_json(methods: [:attachment])
  end
end