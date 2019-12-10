module ApplicationHelper
  def user_avatar user
    user.image.present? ? user.image.url : "avatar_icon.png"
  end

  def format_date date
    date.strftime("%H:%M %d/%m/%Y")
  end

  def recharge_status status
    if status.eql? "pending"
      "<button class='btn btn-warning'>Đang chờ</button>".html_safe
    elsif status.eql? "done"
      "<button class='btn btn-success'>Hoàn thành</button>".html_safe
    else
      "<button class='btn btn-danger'>Từ chối</button>".html_safe
    end
  end
end
