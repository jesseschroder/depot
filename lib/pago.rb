require 'ostruct'

class Pago
  class << self
    ACCEPTED_PAYMENTS = [
      :check,
      :credit_card,
      :po,
    ]

    def make_payment(order_id:, payment_method:, payment_details:)
      raise "Unknown payment_method #{payment_method}" unless ACCEPTED_PAYMENTS.include?(payment_method)

      cleaned_details = payment_details.map do |key, value|
        "#{key.to_s}: #{sanitize_details(value)}"
      end

      Rails.logger.info "Processing #{payment_method.to_s}: #{cleaned_details.join(', ')}"

      sleep 3 unless Rails.env.test?
      Rails.logger.info "Done Processing Payment"
      OpenStruct.new(succeeded?: true)
    end

    private

    def sanitize_details(payment_detail)
      'x' * (payment_detail.length - 3) + payment_detail.last(3)
    end
  end
end
