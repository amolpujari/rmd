#= require active_admin/base
#= require chosen-jquery


$(document).on 'ready page:load', ->
  $('.chosen-categories').chosen
    no_results_text: 'No results matched'
    allow_single_deselect: true

  $('.chosen-categories').chosen().data('chosen').container.off('keyup').on 'keyup', (e) ->
    e.preventDefault()
    e.stopPropagation()
    q = $(e.target).val()
    if q.length>2
      $.getJSON "/categories?q=#{q}", (data) ->
        str = ''
        $.each data, (idx, name_id) ->
          str = str + "<option value='#{name_id[1]}'>#{name_id[0]}</option>"
        $('.chosen-categories option:not(:selected)').remove()
        $('.chosen-categories').prepend(str)
        $('.chosen-categories option:not(:selected)').each ->
          $(this).siblings('[value=\'' + @value + '\']').remove()
        $('.chosen-categories').trigger("chosen:updated");
