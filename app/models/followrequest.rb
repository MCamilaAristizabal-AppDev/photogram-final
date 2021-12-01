# == Schema Information
#
# Table name: followrequests
#
#  id           :integer          not null, primary key
#  status       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recepient_id :integer
#  sender_id    :integer
#
class Followrequest < ApplicationRecord
end
