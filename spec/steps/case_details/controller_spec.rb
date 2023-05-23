require 'rails_helper'

RSpec.describe Steps::CaseDetailsController, type: :controller do
  it_behaves_like 'a generic step controller', Steps::CaseDetailsForm, Decisions::SimpleDecisionTree
  it_behaves_like 'a step that can be drafted', Steps::CaseDetailsForm
end
