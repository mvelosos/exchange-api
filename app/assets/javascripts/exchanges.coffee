$(document).ready ->
 
  $('form').on 'keyup change paste click input', ->
    if $('form').attr('action') == '/convert'
      $.ajax '/convert',
          type: 'GET'
          dataType: 'json'
          data: {
                  source_currency: $("#source_currency").val(),
                  target_currency: $("#target_currency").val(),
                  amount: $("#amount").val()
                }
          error: (jqXHR, textStatus, errorThrown) ->
            alert textStatus
          success: (data, text, jqXHR) ->
            $('#result').val(data.value.toFixed(6))
        return false;
  
  $('#inverter').click ->
    old_source = $("#source_currency").val()
    $("#source_currency").val($("#target_currency").val())
    $("#target_currency").val(old_source)
