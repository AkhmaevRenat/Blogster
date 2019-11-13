$(document).on('turbolinks:load', function () {
  var modal = document.getElementById("myModal");

  // Get the button that opens the modal
  var btn = document.getElementById("myBtn");

  // Get the <span> element that closes the modal
  var span = document.getElementsByClassName("close")[0];

  // When the user clicks on the button, open the modal
  btn.onclick = function () {
    modal.style.display = "block";
  }

  // When the user clicks on <span> (x), close the modal
  span.onclick = function () {
    modal.style.display = "none";
  }

  // When the user clicks anywhere outside of the modal, close it
  window.onclick = function (event) {
    if (event.target == modal) {
      modal.style.display = "none";
    }
  }
  $('.like_management').onclick(function () {
    var $like = $(this);
    var type = $like.data('likeableType');
    var id = $like.data('likeableId');
    var $likesCount = $like.parent().find('.likes_count');
    $.ajax({
      dataType: "json",
      url: '/likes/add',
      method: 'GET',
      data: { likeable_type: type, likeable_id: id },
      success: function (data) {
        $likesCount.html(data.likes_count);
        $like.toggleClass("far fas");
      }
    });
  });
});
