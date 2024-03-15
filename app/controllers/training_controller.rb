class TrainingController < AuthenticatedController
  require 'httparty'

  def train_model
    debugger
    blob = Dataset.first.arquivo
    path = rails_blob_path(blob, disposition: 'attachment', only_path: true)
    # Download blob contents
    blob_data = HTTParty.get("http://localhost:3000#{path}").body
    # Save blob contents to a temporary file
    temp_file = Tempfile.new(['dataset', '.csv'])
    temp_file.binmode
    temp_file.write(blob_data)
    temp_file.rewind
    debugger
    # Pass the temporary file to HTTParty
    response = HTTParty.post('http://localhost:5000/train', body: { dataset: temp_file })
    debugger
    result = JSON.parse(response.body)
    accuracy = result['accuracy']
    confusion_matrix = result['confusion_matrix']
    # Close and delete the temporary file
    temp_file.close
    temp_file.unlink
  end
end
