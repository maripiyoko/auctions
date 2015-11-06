$ ->
  $auction_name = $('#auction_name')
  $auction_description = $('#auction_description')

  $('#auction_product_id').change ->
    product_id = $(this).val()
    if product_id.length > 0
      $.ajax
        url: "/my/products/#{product_id}"
        dataType: "json"
        success: (result) ->
          $auction_name.val(result.name)
          $auction_description.val(result.description)
          $auction_name.focus()
        error: (result) ->
          alert('error!')
          console.log(result)
    else
      $auction_name.val("")
      $auction_description.val("")