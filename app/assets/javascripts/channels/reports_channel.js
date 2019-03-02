(function () {
  jQuery(document).on("ready page:load", function () {
    var comments = $("#comments");
    if ($("#comments").length > 0) {
      App.report_comment = App.cable.subscriptions.create({
        channel: "ReportsChannel",
        report_id: comments.data("report-id")
      }, {
          received: function (data) {
            return this.appendLine(data);
          },
          appendLine: function (data) {
            var html = this.createLine(data);
            return comments.append(html);
          },
          createLine: function (data) {
            return `
              <div class="mB-20">
                <div class="text-muted row">
                  <span class="c-red-400">
                    ${data["user_name"]}
                  </span>
                  <i class="fc-day-number">
                    ${data["created_at"]}
                  </i>
                </div>
                <div class="comment-content peers fxw-nw ai-c
                  pY-3 pX-10 bgc-red-100 bdrs-2 lh-3/2" >
                  ${data["comment"]}
                </div>
              </div>
              `;
          },
          send_comment: function (comment, report_id) {
            return this.perform("send_comment", {
              comment: comment,
              report_id: report_id
            });
          }
        });
      return $("#new_comment").submit(function (e) {
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
    }
  });
}).call(this);
