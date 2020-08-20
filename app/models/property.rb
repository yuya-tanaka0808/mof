class Property < ApplicationRecord
  #アソシエーション設定,親モデルのデータを削除した時に子モデルも一緒に削除される。
  has_many :stations, dependent: :destroy, inverse_of: :property
  #reject_all_blank関数でtrueが出たパラメータは、送信データから除外させていく。
  accepts_nested_attributes_for :stations, allow_destroy: true,reject_if: :all_blank
end
