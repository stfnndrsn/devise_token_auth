module Overrides
  class TokenValidationsController < DeviseTokenAuth::TokenValidationsController
    OVERRIDE_PROOF = '(^^,)'

    def validate_token
      # @resource will have been set by set_user_by_token concern
      if @resource
        render json: {
          success: true,
          data: @resource.as_json(except: [
            :tokens, :created_at, :updated_at
          ]),
          override_proof: OVERRIDE_PROOF
        }
      else
        render json: {
          success: false,
          errors: {
            full_messages: [I18n.t('devise_token_auth.token_validations.invalid')]
          }
        }, status: 401
      end
    end
  end
end
