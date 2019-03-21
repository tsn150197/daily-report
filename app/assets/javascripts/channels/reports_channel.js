(function () {
  $(document).on("ready page:load", function () {
    var comments = $("#comments");
    App.report_comment = App.cable.subscriptions.create({
      channel: "ReportsChannel",
      report_id: comments.data("report-id")
    }, {
        received: function (data) {
          if (data["delete"] !== undefined) {
            return this.deleteComment(data);
          } else {
            return this.appendLine(data);
          }
        },
        appendLine: function (data) {
          var html = this.createLine(data);
          return comments.append(html);
        },
        createLine: function (data) {
          html_comment = `
            <div class="mB-50" data-comment-id="${data["comment_id"]}">
              <div class="text-muted row">
                <span class="c-red-400">
                  <img src="${data["user_avatar"]}", class="w-2r">
                  ${data["user_name"]}
                </span>
              </div>
              <div class="row peers fxw-nw ai-c pY-3 pX-10 lh-3/2
                comment-content comment-content-new">
                ${data["comment"]}
              </div>
              <div class="row float-right mR-30">
                <i>${data["created_at"]}</i>
              </div>
              <div class="row float-right" style="clear:right">`;
          if (gon.current_user_id == data["user_id"]) {
            html_comment += `
                <a href="#" class="mR-30 c-red-200 delete-comment"
                  data-comment-id="${data["comment_id"]}">
                  <i class="fa fa-lg fa-times"></i>
                </a>`;
          }
          html_comment += `
                <a href="#" class="mR-30">
                  <i class="fa fa-lg fa-reply"></i>
                </a>
              </div>
            </div>`;
          return html_comment;
        },
        deleteComment: function (data) {
          var html = $("div[data-comment-id='" + data["comment_id"] + "']");
          html.find("a").remove();
          html.find(".comment-content").html(I18n.t("js.comments.delete"));
        },
        send_comment: function (comment, report_id) {
          return this.perform("send_comment", {
            comment: comment,
            report_id: report_id
          });
        },
        delete_comment: function (comment_id, report_id) {
          return this.perform("delete_comment", {
            comment_id: comment_id,
            report_id: report_id
          });
        }
      });

    $(document).on("submit", "#new_comment", function (e) {
      var $this, textarea;
      $this = $(this);
      textarea = $this.find("#comment_content");
      if ($.trim(textarea.val()).length > 1) {
        App.report_comment.send_comment(textarea.val(), comments.data("report-id"));
        textarea.val("");
      }
      $(".commet-report").animate({
        scrollTop: $(".commet-report")[0].scrollHeight
      }, 1000);
      e.preventDefault();
      return false;
    });

    $(document).on("click", ".delete-comment", function (e) {
      comment_id = $(this).data("comment-id");
      var check = confirm(I18n.t("js.comments.confirm"));
      if (check == true) {
        App.report_comment.delete_comment(comment_id, comments.data("report-id"));
      }
      e.preventDefault();
      return false;
    });
  });
}).call(this);
