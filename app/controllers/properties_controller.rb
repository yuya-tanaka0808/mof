class PropertiesController < ApplicationController
 before_action :set_property, only: [:show,:edit,:update,:destroy]

  def index
    @properties = Property.all
  end

  def new
  #インスタンスをインスタンス変数に代入。ビューにデータを渡す
    @property = Property.new
  #buildメソッドを使用し、propertyモデルに属するstationモデルのインスタンスを新たに生成する。新規登録の時点で２駅保存できる
    2.times { @property.stations.build }
   end

   def create
   #paramsメソッドを使用し、送られてきたparameterを全て取得。モデルにDB操作の命令を出す。
     @property = Property.new(property_params)
      if @property.save
      #一覧画面へ遷移して、"物件を登録しました！"とメッセージを表示する。
        redirect_to properties_path, notice: "物件を登録しました！"
      else
      #入力フォーム(new.html.erb)を再描写
        render :new
      end
   end

  def show
  end

  def edit
    @property.stations.build
  end

  def update
    if @property.update(property_params)
      redirect_to properties_path, notice: "物件を編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @property.destroy
    redirect_to properties_path, notice: "物件を削除しました"
  end

  private
  #paramsメソッドにより、parametersの値を取得。
  def property_params
    params.require(:property).permit(
      :name,
      :rent,
      :address,
      :age,
      :content,
       #attributesメソッドを使用し、インスタンスの属性（オブジェクトが持っている値）一覧を取得
      stations_attributes: [
        :station_name,
        :line_name,
        :minutes_on_foot,
        :property_id,
        :id,
        :_destroy,
      ],
    )
  end

  def set_property
   #parameterのidを利用して、データベースからデータを取得。
    @property = Property.find(params[:id])
  end

end
