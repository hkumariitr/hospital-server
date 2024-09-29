User.create(email: 'receptionist@example.com', password: 'password', role: 'receptionist')
User.create(email: 'doctor@example.com', password: 'password', role: 'doctor')

10.times do |i|
  Patient.create(
    name: "Patient #{i+1}",
    email: "patient#{i+1}@example.com",
    phone: "123-456-78#{sprintf('%02d', i+1)}",
    address: "123 Main St, City #{i+1}"
  )
end
