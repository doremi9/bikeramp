ActiveAdmin.register Ride do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :start_address, :destination_address, :price, :date, :distance
end
