require 'spec_helper'
module WtfSfx
  pmids.each do |pmid|
    describe "Pubmed resolution for pmid #{pmid} in the SFX API", type: :feature do
      subject(:api_url_with_pmid) { "#{API_URL}&rft_id=info%3Apmid%2F#{pmid}" }
      # Print out the HTML if we don't find any full text
      after(:each) do |example|
        unless example.exception.nil?
          p "SFX API response for #{api_url_with_pmid}\n"
          p page.html
        end
      end
      it "has a full text service" do
        visit api_url_with_pmid
        service_types = page.all(:xpath, '//target/service_type').
          collect { |element| element.native.all_text }
        expect(service_types).to include("getFullTxt")
      end
    end
  end
end
