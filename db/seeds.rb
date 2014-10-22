# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.new(
    email: 'quanpower@gmail.com',
    first_name: 'WeiQuan',
    last_name: 'Zhang',
    roles: ['admin'],
    password: 'caojing1010',
    password_confirmation: 'caojing1010'
)
admin.skip_confirmation!
admin.save!