require 'sinatra'
require 'mongoid'
require 'mongo'

require_relative 'company'
 
Mongoid.load!("mongoid.yml")

get '/' do
  company = Company.new(:company_code => "123456", :company_name => "Example Company")
  company.save
 
  "#{company.company_name} saved with code: #{company.company_code}"
end

get '/companies' do
    companies = Company.all
    companies.to_json
end

get '/company/new' do  
    erb :company_form  
end 

get '/company/:company_code' do
    company = Company.where(company_code: params[:company_code])

    company.to_json
end

post '/company' do
    company = Company.new(
        company_name: params[:company_name],
        company_code: params[:company_code]
    )

    company.save

    "Company with name: #{company.company_name} and code: #{company.company_code} saved!"
end

