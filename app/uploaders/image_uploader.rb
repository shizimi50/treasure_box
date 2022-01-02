class ImageUploader < CarrierWave::Uploader::Base #rails g uploader imageで画像のアップローダークラスを作成
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick #リサイズ、画像形式を変更に必要

  #上限変更
  process :resize_to_limit => [700, 700]

  #JPGで保存
  process :convert => 'jpg'

  #サムネイルを生成
  version :thumb do
    process :resize_to_limit => [300, 300]
  end

  # jpg,jpeg,gif,pngのみ（アップロードが許可されている拡張子のホワイトリストを追加）
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  #ファイル名を変更し拡張子を同じにする
  def filename
    super.chomp(File.extname(super)) + '.jpg' 
  end

  #日付で保存（  # アップロードされるファイルのファイル名を上書きする。）
  #詳細は uploader/store.rb を確認
  def filename
    if original_filename.present?
      time = Time.now
      name = time.strftime('%Y%m%d%H%M%S') + '.jpg'
      name.downcase
    end
  end

  # デフォルト指定（アップロードしたファイルはpublic/配下に保存）
  storage :file

  # アップロードされたファイルが保存されるディレクトリの指定
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  #ーーーー ASURAでは下記のように記載ーーーーー
  # def store_dir
  #   "#{ENV.fetch('main_domain')}/#{model.db_name}/uploads/staff/logo/#{model.id}"
  # end
  # ーーーーーーーーーーーーーーーーーーーーーー

  # 画像アップロードしていない場合のデフォルト画像設定
  def default_url(*args)
    "default.jpg"
  end

end
