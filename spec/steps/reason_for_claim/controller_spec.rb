require 'rails_helper'

RSpec.describe Steps::ReasonForClaimController, type: :controller do
  it_behaves_like 'a generic step controller', Steps::ReasonForClaimForm, Decisions::SimpleDecisionTree
end
