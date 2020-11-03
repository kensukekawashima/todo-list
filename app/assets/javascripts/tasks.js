$(function () {
  // コメント編集エリアを表示
  // これだとupdateボタンを押しても反応しない。リロードする必要がある
  // $('.js-edit-comment-button').on('click', function(){
  $(document).on('click', ".js-edit-comment-button", function(){
    const commentId = $(this).data('comment-id');
    const commentLabelArea = $('#js-comment-label-' + commentId);
    const commentTextArea = $('#js-textarea-comment-' + commentId);
    const commentButton = $('#js-comment-button-' + commentId);

    commentLabelArea.hide();
    commentTextArea.show();
    commentButton.show();
  });

  // コメント編集エリアを非表示
  $(document).on('click', ".comment-cancel-button", function(){
    const commentId = $(this).data('cancel-id');
    const commentLabelArea = $('#js-comment-label-' + commentId);
    const commentTextArea = $('#js-textarea-comment-' + commentId);
    const commentButton = $('#js-comment-button-' + commentId);
    const commentError = $('#js-comment-post-error-' + commentId);

    commentLabelArea.show();
    commentTextArea.hide();
    commentButton.hide();
    commentError.hide();
  });

  // コメント更新
  $(document).on('click', '.comment-update-button', function() {
    const commentId = $(this).data('update-id');
    const textField = $('#js-textarea-comment-' + commentId);
    const body = textField.val();

    $.ajax({
      url: '/users/:id/tasks/' + commentId,
      type: 'PUT',
      data: {
        task: {
          // ajaxで変更したいDBのカラムを設定する。今回のbodyとはconstで定義したtextfieldの値
          title: body
        }
      }
    })
      // 更新成功時にcontrollerのupdateからdataに値が返ってくる
      .done(function (data) {
        const commentLabelArea = $('#js-comment-label-' + commentId);
        const commentTextArea = $('#js-textarea-comment-' + commentId);
        const commentButton = $('#js-comment-button-' + commentId);
        const commentError = $('#js-comment-post-error-' + commentId);
        
        commentLabelArea.show();
        // data.titleのtitleはTaskテーブルのtitleカラム
        commentLabelArea.text(data.title);
        commentTextArea.hide();
        commentButton.hide();
        commentError.hide();
      })

      .fail(function () {
        const commentError = $('#js-comment-post-error-' + commentId);
        commentError.text("コメントを入力してください")
      })
  });
});