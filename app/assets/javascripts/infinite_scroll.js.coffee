jQuery ->
  if $('.pagination').length
    $(window).scroll ->
      url = $(".pagination a[rel='next']").attr('href')
      if url &&  $(window).scrollTop() > $(document).height() - $(window).height() - 400
        $('.pagination').text('Fetching more results...')
        $.getScript(url)
    $(window).scroll()
