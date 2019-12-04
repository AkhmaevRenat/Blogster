$(document).ready(function () {
  $(document).on("click", ".add_like", function (event) {
    event.preventDefault();
    var $like = $(this).closest('.add_like');
    var type = $like.data('likeableType');
    var id = $like.data('likeableId');
    var $likesCount = $like.parent().find('.likes_count');
    console.log(type + " " + id);
    $.ajax({
      dataType: "json",
      url: '/likes/add',
      method: 'GET',
      data: { likeable_type: type, likeable_id: id },
      success: function (data) {
        console.log(data);
        $likesCount.html(data.likes_count);
        $like.toggleClass("far fas");
        $like.toggleClass("add_like remove_like");
      }
    });
  });

  $(document).on("click", ".remove_like", function (event) {
    event.preventDefault();
    var $like = $(this).closest('.remove_like');
    var type = $like.data('likeableType');
    var id = $like.data('likeableId');
    var $likesCount = $like.parent().find('.likes_count');
    console.log(type + " " + id);
    $.ajax({
      dataType: "json",
      url: '/likes/remove',
      method: 'GET',
      data: { likeable_type: type, likeable_id: id },
      success: function (data) {
        console.log(data);
        $likesCount.html(data.likes_count);
        $like.toggleClass("fas far");
        $like.toggleClass("remove_like add_like");
      }
    });
  });
});
