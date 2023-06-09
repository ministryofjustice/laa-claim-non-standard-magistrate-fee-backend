LaaMultiStepForms::Engine.routes.draw do
  scope module: 'laa_multi_step_forms' do
    resource :errors, only: [] do
      get :application_not_found
      get :invalid_session
      get :unhandled
      get :unauthorized
      get :not_enrolled
      get :not_found
    end
  end
end
