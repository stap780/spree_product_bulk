document.addEventListener("spree:load", function() {
  console.log('bulk load');

  $('#selectAll').click(function() {
    if (this.checked) {
      $(':checkbox').each(function() {
        this.checked = true;
      });
    } else {
      $(':checkbox').each(function() {
        this.checked = false;
      });
    }
  });

  $('#deleteAll').click(function() {
    // event.preventDefault();
    var array = [];
    $('#listing_products tbody :checked').each(function() {
      array.push($(this).val());
    });
    console.log(array);

    //$("#delete_product_ids").val(array);
    $('.bulk_product_ids').each(function() {
      $(this).val(array);
    });

  });


  $("#updateTaxon").click(function(event) {
    // event.preventDefault();
    var array = [];
    $('#listing_products tbody :checked').each(function() {
      array.push($(this).val());
    });

    $('.bulk_product_ids').each(function() {
      $(this).val(array);
    });
  });


})