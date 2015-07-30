require 'spec_helper'

describe 'Passenger Management' do
  context 'GET' do
    before :all do
      @request = gen_request_with_token :get, '/passengers'
    end
    it 'response should have appropriate structure' do
      get @request[:url], @request[:headers]
      expect_json_keys :passengers, [
                                      [
                                          :id,
                                          :modifiedAt, [:date, :time, :timeZone],
                                          :createdAt, [:date, :time, :timeZone],
                                          :languageCode,
                                          :phone,
                                          :lastName,
                                          :firstName,
                                          :title,
                                          :additionalDetails, [:legacyID, :salesForceID],
                                          :links, [:user, :ravellingUser]
                                      ]
                                  ],
                       :links, [
                           :'passengers.user', [:type],
                           :'passengers.travellingUser', [:type],
                       ],
                       :linked
      # todo expect_json_types
    end
  end
  context 'POST' do
    context 'create new passenger' do
      before :all do
        @request = gen_request_with_token :post, '/passengers'
        @request.merge!({body:
                             {
                                 nickname: 'nickname',
                                 title: 'title',
                                 firstName: 'firstname',
                                 lastName: 'lastname',
                                 phone: '001',
                                 companyName: 'companyname',
                                 passportNumber: '2',
                                 passportExpires: '2020-02-20',
                                 issueDate: '1010-01-10',
                                 issuingAuthority: 'issuingauthority',
                                 birthDate: '1919-09-19',
                                 nationality: 'nationality',
                                 specialRequirements: 'specialrequirements',
                                 mobilePhone: '002',
                                 languageCode: 'EN',
                                 isVisibleToUser: 'false'
                             }
                         #        {"nickname": "nickname", "title": "title", "firstName": "firstname", "lastName": "lastname", "phone": "001", "companyName": "companyname", "passportNumber": "2", "passportExpires": "2020-02-20", "issueDate": "1010-01-10", "issuingAuthority": "issuingauthority", "birthDate": "1919-09-19", "nationality": "nationality", "specialRequirements": "specialrequirements", "mobilePhone": "002", "languageCode": "EN", "isVisibleToUser": "false"}
                        })
      end
      it 'should return success' do
        post @request[:url], @request[:body], @request[:headers]
        expect_json
      end
    end

  end
end