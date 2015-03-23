json.array!(@reservations) do |reservation|
  json.extract! reservation, :id, :slug
  json.url reservation_url(reservation, format: :json)
end
