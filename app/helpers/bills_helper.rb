module BillsHelper
  def bill_status_label(status, true_val, false_val)
    attributes = {}
    content = nil

    if status
      attributes["class"] = "label label-success"
      content = true_val
    else
      attributes["class"] = "label label-danger"
      content = false_val
    end

    content_tag :span, content, attributes
  end

  def all_bill_status(bill)

    status = ''

    if !bill.is_active
      status = status + bill_status_label(bill.is_active, "", "INACTIVE")
      status = add_spacer(status)
    end

    status = status + bill_status_label(bill.is_paid, "PAID", "UNPAID")
    status = add_spacer(status)

    if bill.is_overdue
      status = status + bill_status_label(bill.is_overdue, "", "OVERDUE")
      status = add_spacer(status)
    end

    raw(status)
  end

  def add_spacer(status)
    status = status + "&nbsp;"
  end
end
