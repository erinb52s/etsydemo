jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  listing.setupForm()

listing =
  setupForm: ->
    $('#edit_user_registration').submit ->
      if $('input').length > 6
        $('input[type=submit]').attr('disabled', true)
        Stripe.bankAccount.createToken($('#edit_user_registration'), listing.handleStripeResponse)
        false

  handleStripeResponse: (status, response) ->
    if status == 200
      $('#edit_user_registration').append($('<input type="hidden" name="stripeToken" />').val(response.id))
      $('#edit_user_registration')[0].submit()
    else
      $('#stripe_error').text(response.error.message).show()
      $('input[type=submit]').attr('disabled', false)