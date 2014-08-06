# Default Admin user
User.create(
      first_name: "Mohd Amree",
      last_name: "Che Mohd Zaid",
      email: "mohd.amree@gmail.com",
      password: "password",
      password_confirmation: "password",
      access_level: 100)

Country.create(
          name: 'Malaysia',
          calling_code: '+60',
          sms_rate: '0.1',
          is_active: true)
