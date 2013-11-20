require 'spec_helper'
module WtfSfx
  pmids.each do |pmid|
    describe "Pubmed resolution for pmid #{pmid} in the SFX API", :type => :feature do
      it "has a full text service" do
        visit "#{API_URL}&rft_id=info%3Apmid%2F#{pmid}"
        service_types = page.all(:xpath, '//target/service_type').
          collect { |element| element.native.all_text }
        expect(service_types).to include("getFullTxt")
      end
    end
  end
end
