module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    class EpsilonConvenienceStoreGateway < EpsilonBaseGateway

      RESPONSE_KEYS = DEFAULT_RESPONSE_KEYS + [
        :convenience_store_limit_date,
        :convenience_store_payment_slip_url,
        :company_code,
      ]

      def purchase(amount, payment_method, detail = {})
        params = {
          contract_code:  self.contract_code,
          user_id:        detail[:user_id],
          user_name:      detail[:user_name],
          user_mail_add:  detail[:user_email],
          item_code:      detail[:item_code],
          item_name:      detail[:item_name],
          order_number:   detail[:order_number],
          st_code:        '00100-0000-0000',
          mission_code:   EpsilonMissionCode::PURCHASE,
          item_price:     amount,
          process_code:   1,
          xml:            1,
          conveni_code:   payment_method.code,
          user_tel:       payment_method.phone_number,
          user_name_kana: payment_method.name,
        }

        params[:memo1] = detail[:memo1] if detail.has_key?(:memo1)
        params[:memo2] = detail[:memo2] if detail.has_key?(:memo2)

        commit('receive_order3.cgi', params, RESPONSE_KEYS)
      end
    end
  end
end
