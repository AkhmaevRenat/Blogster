$(document).ready(function () {
  $('.add_like').click(function () {
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