$(document).ready(function() {
  var toggleFlg = false;

  $('#edit_in_place').on('click', function() {
      var windowScrolltop = $(window).scrollTop();
      toggleBestInPlace();
  
      // XXX:
      //  即座に scrollTop をセットすると、スクロール位置が調整できないため
      //  50ms 待つ
      setTimeout(function() {
        $(window).scrollTop(windowScrolltop);
      }, 50);
  
  });

  function toggleBestInPlace () {
    if (toggleFlg) {
      toggleFlg = false;
      /* Deactivating Best In Place */
      jQuery(".best_in_place").disable_best_in_place();
    } else {
      toggleFlg = true;
      /* Activating Best In Place */
      jQuery(".best_in_place").enable_best_in_place();
    }
  }

  $.fn.disable_best_in_place = function () {
    function unsetBestInPlace(element) {
      element.removeClass('enabled');
      // best-in-place によって挿入された placeholder をクリーンアップする
      // (空白文字があるとソートが意図した通りできなくなるため)
      element.text(element.text().trim());
    }

    this.each(function() {
      unsetBestInPlace($(this));
    });
  };


  $.fn.enable_best_in_place = function () {
    this.each(function() {
      var element = $(this);
      element.addClass('enabled');
    });
    jQuery(".best_in_place").best_in_place();
  };

});


