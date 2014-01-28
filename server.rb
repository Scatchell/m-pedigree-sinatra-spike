require 'sinatra'
require 'mongoid'
require 'mongo'

require_relative 'company'

Mongoid.load!("mongoid.yml")

def load_all_companies_from_json
    JSON.parse(File.read('/Users/ThoughtWorks/sideProjects/Ruby/sinatra-mongo-spike/all_companies.json')).inject([]) do |companies, company|
        companies.push Company.new(company_code: company['company_code'], company_name: company['company_name'])
    end
end

get '/' do
    load_all_companies_from_json.each do |company|
        company.save
        puts "#{company.company_name} saved with code: #{company.company_code}"
    end

    'done, check console'
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

