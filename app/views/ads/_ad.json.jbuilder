json.extract! ad, :id, :url, :impressions, :user_id, :image, :views, :live, :clicks, :title, :slug, :website_id, :created_at, :updated_at
json.url ad_url(ad, format: :json)