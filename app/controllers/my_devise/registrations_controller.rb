class MyDevise::RegistrationsController < Devise::RegistrationsController
  layout 'application', only: :edit
  layout 'split_with_paintings', except: :edit
end
