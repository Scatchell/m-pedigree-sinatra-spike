require 'mongoid'
 
class Company
  include Mongoid::Document

  field :company_code, type: Integer
  field :company_name, type: String
end
