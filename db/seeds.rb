# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

campus = [
          {
            description: "Gragoatá",
            street_adress: "Rua Prof. Marcos Waldemar de Freitas Reis",
            number: "s/n",
            district: "São Domingos/Gragoatá",
            city: "Niterói",
            CEP: "24210-201",
            status: 0,
            deactivation_date: nil
          },
          {
            description: "Praia Vermelha",
            street_adress: "Rua Passo da Pátria",
            number: "152-470",
            district: "São Domingos",
            city: "Niterói",
            CEP: "24210-240",
            status: 0,
            deactivation_date: nil
          },
          {
            description: "Valonguinho",
            street_adress: "Rua Mario Santos Braga",
            number: "30",
            district: "Centro",
            city: "Niterói",
            CEP: "24020-140",
            status: 0,
            deactivation_date: nil
          }
]

campus.each do |campu|
  Campu.find_or_create_by!(campu)
end