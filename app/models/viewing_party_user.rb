# frozen_string_literal: true

class ViewingPartyUser < ApplicationRecord
  belongs_to :user
  belongs_to :viewing_party

  validates :hosting, inclusion: [true, false]
end
