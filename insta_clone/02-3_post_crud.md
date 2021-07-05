# 画像の挿入

## CarrierWaveを使用した

```
gem 'carrierwave'
```
gemでインストール


### アップローダーの作成

```
$ rails g uploader image

```
app/uploaders/image_uploader.rb に下記ファイルが作成される。

```ruby
class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_whitelist
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end


```

### モデルを修正する。

modelに関連付ける

例）
post.rb

```ruby
class Post < ApplicationRecord

mount_uplodaters :images, ImageUploader

```

####+a

* 複数画像読み込む場合
mount_uplodaterも複数形にする。
serializeメソッド

```ruby
    # 複数の画像を取り扱う場合、serializeメソッドが必要
    # JSON形式でなくとも、複数の画像を受け取ることは可能
    # ただ、posts_controllerにてJSON形式でデータを受け取るよう指定しているので、整合性を取る必要
    serialize :images, JSON
```
strong_parameterをJson形式で受け取るかき方。

```ruby
private

   def post_params
       # images:[]とすることで、JSON形式でparamsを受け取る
       params.require(:post).permit(:body, {images: []})
   end

```



### Viewの変更

画像をアップロードするページ
/ multiple: trueをつけることで複数のファイルをアップロードできる。

```ruby
# form_with省略
= f.label :images
= f.file_field :images, multiple: true
```


画像を表示するコード
sizeは任意。
```ruby
- post.images.each do |image|
      #image_tagを使うと、画像を簡単に配置できる
      #urlメソッドはcarrierwaveのメソッド
    = image_tag image.url, size: '100x100'
```

https://www.sejuku.net/blog/65175

https://qiita.com/29dai/items/2aca6e4b69a4cf47bb26

### 画像サイズをリサイズする。

* Imagemagickをインストール

```
$brew install imagemagick
```

* gemはRMagicまたはMiniMagicをインストール

* app/uploaders/image_uploader.rbの下記表示のコメントアウトを外す。
```ruby
include CarrierWave::MiniMagick

```
* 下記コマンドで画像のリサイズを可能にする。

```ruby

process resize_to_fit: [1000, 1000]

```

https://qiita.com/Tatsu88/items/66374abda7245a006ea0
