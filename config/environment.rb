# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
MyDraft::Application.initialize!
Time::DATE_FORMATS[:user_datetime] = "%Y-%m-%d в %H:%M:%S"
Time::DATE_FORMATS[:article_datetime] = "%Y/%m/%d в %H:%M:%S"
